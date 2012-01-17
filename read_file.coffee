fs = require 'fs'

# Using this class makes sense for large files where memory is
# constrained, or where you want a large amount of concurrency,
# but it's overkill for most situations.  For small
# files, you would more likely do something like this:
#
#   for line in fs.readFileSync(fn).toString().split '\n'
#
LineByLineReader = (fn, cb) ->
  fs.open fn, 'r', (err, fd) ->
    bufsize = 80
    pos = 0
    frag = new Buffer(bufsize)
    cb
      next_line: (line_cb, done_cb) ->
        fs.read fd, frag, 0, bufsize, pos, (err, bytesRead) ->
          s = frag.toString('utf8', 0, bytesRead)
          pos += bytesRead
          if (bytesRead)
            line_cb s
          else
            fs.closeSync(fd)
            done_cb()

do ->  
  fn = 'foo.coffee'
  LineByLineReader fn, (reader) -> 
    callbacks =
      process_line: (line) ->
         console.log line
         reader.next_line callbacks.process_line, callbacks.all_done
      all_done: ->
        console.log "DONE!"
    reader.next_line callbacks.process_line, callbacks.all_done
