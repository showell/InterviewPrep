net = require("net")
sys = require("sys")

EventEmitter = require("events").EventEmitter

ChatServer = ->
  @chatters = {}
  @server = net.createServer(@handleConnection.bind(this))
  @server.listen 1212, "localhost"
  null

ChatServer::isNicknameLegal = (nickname) ->
  return false  unless nickname.replace(/[A-Za-z0-9]*/, "") is ""
  for used_nick of @chatters
    return false  if used_nick is nickname
  true

ChatServer::handleConnection = (connection) ->
  console.log "Incoming connection from " + connection.remoteAddress
  connection.setEncoding "utf8"
  chatter = new Chatter(connection, this)
  chatter.on "chat", @handleChat.bind(this)
  chatter.on "join", @handleJoin.bind(this)
  chatter.on "leave", @handleLeave.bind(this)

ChatServer::handleChat = (chatter, message) ->
  @sendToEveryChatterExcept chatter, chatter.nickname + ": " + message

ChatServer::handleJoin = (chatter) ->
  console.log chatter.nickname + " has joined the chat."
  @sendToEveryChatter chatter.nickname + " has joined the chat."
  @addChatter chatter

ChatServer::handleLeave = (chatter) ->
  console.log chatter.nickname + " has left the chat."
  @removeChatter chatter
  @sendToEveryChatter chatter.nickname + " has left the chat."

ChatServer::addChatter = (chatter) ->
  @chatters[chatter.nickname] = chatter

ChatServer::removeChatter = (chatter) ->
  delete @chatters[chatter.nickname]

ChatServer::sendToEveryChatter = (data) ->
  for nickname of @chatters
    @chatters[nickname].send data

ChatServer::sendToEveryChatterExcept = (chatter, data) ->
  for nickname of @chatters
    @chatters[nickname].send data  unless nickname is chatter.nickname


Chatter = (socket, server) ->
  EventEmitter.call this
  @socket = socket
  @server = server
  @nickname = ""
  @lineBuffer = new SocketLineBuffer(socket)
  @lineBuffer.on "line", @handleNickname.bind(this)
  @socket.on "close", @handleDisconnect.bind(this)
  @send "Welcome! What is your nickname?"
  null

sys.inherits Chatter, EventEmitter

Chatter::handleNickname = (nickname) ->
  console.log nickname
  if server.isNicknameLegal(nickname)
    @nickname = nickname
    @lineBuffer.removeAllListeners "line"
    @lineBuffer.on "line", @handleChat.bind(this)
    @send "Welcome to the chat, " + nickname + "!"
    @emit "join", this
  else
    @send "Sorry, but that nickname is not legal or is already in use!"
    @send "What is your nickname?"

Chatter::handleChat = (line) ->
  @emit "chat", this, line

Chatter::handleDisconnect = ->
  @emit "leave", this

Chatter::send = (data) ->
  @socket.write data + "\r\n"


SocketLineBuffer = (socket) ->
  EventEmitter.call this
  @socket = socket
  @buffer = ""
  @socket.on "data", @handleData.bind(this)
  null

sys.inherits SocketLineBuffer, EventEmitter

SocketLineBuffer::handleData = (data) ->
  console.log "Handling data", data
  i = 0

  while i < data.length
    char = data.charAt(i)
    @buffer += char
    if char is "\n"
      @buffer = @buffer.replace("\r\n", "")
      @buffer = @buffer.replace("\n", "")
      @emit "line", @buffer
      @buffer = ""
    i++

server = new ChatServer()