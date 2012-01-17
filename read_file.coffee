fs = require 'fs'

fn = 'foo.coffee'
fs.open fn, 'r', (err, fd) ->
  bufsize = 8192
  pos = 0
  frag = new Buffer(bufsize)
  next_line = ->
    fs.read fd, frag, 0, 8192, pos, (err, bytesRead) ->
      console.log frag.toString('utf8', 0, bytesRead)
      pos += bytesRead
      if (bytesRead)
        next_line()
      else
        fs.closeSync(fd)
  next_line()