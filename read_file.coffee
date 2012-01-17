# This module shows two ways to read a file line-by-line in node.js.
fs = require 'fs'

# First, let's keep things simple, and do things synchronously.  This
# approach is well-suited for simple scripts.
do ->
  fn = "read_file.coffee"
  for line in fs.readFileSync(fn).toString().split '\n'
    console.log line
  console.log "DONE SYNC!"

# Now let's complicate things.
#
# Use the following code when files are large, and memory is
# constrained and/or where you want a large amount of concurrency.
#
# Protocol:
#   Call LineByLineReader, which calls back to you with a reader.
#   The reader has two methods.
#      next_line: call to this when you want a new line
#      close: call this when you are done using the file before
#         it has been read completely
#
#   When you call next_line, you must supply two callbacks:
#     line_cb: called back when there is a line of text
#     done_cb: called back when there is no more text in the file
LineByLineReader = (fn, cb) ->
  fs.open fn, 'r', (err, fd) ->
    bufsize = 8192
    pos = 0
    text = ''
    eof = false
    closed = false
    reader =
      next_line: (line_cb, done_cb) ->
        lines = text.split '\n'
        if lines.length > 1
          line = lines.shift()
          text = lines.join '\n'
          line_cb line
        else if eof
          console.log "eof", JSON.stringify text
          if text
            last_line = text
            text = ''
            line_cb last_line
          else
            done_cb()
        else
          frag = new Buffer(bufsize)
          fs.read fd, frag, 0, bufsize, pos, (err, bytesRead) ->
            s = frag.toString('utf8', 0, bytesRead)
            text += s
            pos += bytesRead
            if (bytesRead)
              reader.next_line line_cb, done_cb
            else
              eof = true
              fs.closeSync(fd)
              closed = true
              reader.next_line line_cb, done_cb
        close: ->
          # The reader should call this if they abandon mid-file.
          fs.closeSync(fd) unless closed
          
    cb reader

# Test our interface here.
do ->  
  fn = 'read_file.coffee'
  LineByLineReader fn, (reader) -> 
    callbacks =
      process_line: (line) ->
         console.log line
         reader.next_line callbacks.process_line, callbacks.all_done
      all_done: ->
        console.log "DONE ASYNC!"
    reader.next_line callbacks.process_line, callbacks.all_done
