CATEGORY = 'CoffeeScript'
CATEGORY_PAGES_SELECTOR = "#mw-pages li a"
HOST = 'rosettacode.org'

http = require 'http'
# use npm install for below modules:
soupselect = require 'soupselect'
htmlparser = require 'htmlparser'

process_task_page = (link_info, cb) ->
  console.log link_info
  cb()

process_language_page = (cb) -> 
  handler = (err, dom) ->
    links = soupselect.select dom, CATEGORY_PAGES_SELECTOR
    link_info = (link) ->
      href: link.attribs.href
      title: link.attribs.title
    links = (link_info(link) for link in links)
    process_list links, process_task_page, cb

  process_page "/wiki/Category:#{CATEGORY}", handler

process_page = (path, cb) -> 
  wget path, (body) ->
    handler = new htmlparser.DefaultHandler(cb)
    parser = new htmlparser.Parser(handler)
    parser.parseComplete body

process_list = (list, f, done_cb) ->
  # WOO HOO! async complexity, hopefully somewhat encapsulated here
  # This serializes callback-based invocations of f for each element of our list.
  i = 0
  _process = ->
    if i < list.length
      f list[i], ->
        i += 1
        _process()
    else
      done_cb()
  _process()

wget = (path, cb) ->
  options =
    host: HOST
    path: path
  
  req = http.request options, (res) ->
    s = ''
    res.on 'data', (chunk) ->
      s += chunk
    res.on 'end', ->
      cb s
  req.end()

process_language_page -> console.log "DONE!"
