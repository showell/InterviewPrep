# use npm install for below modules:
soupselect = require 'soupselect'
htmlparser = require 'htmlparser'

# configure these for your language
CATEGORY = 'CoffeeScript'
LANG_SELECTOR = 'pre.coffeescript.highlighted_source'

####
CATEGORY_PAGES_SELECTOR = "#mw-pages li a"
HOST = 'rosettacode.org'

http = require 'http'


process_task_page = (link_info, done) ->
  path = link_info.href
  process_page path, (err, dom) ->
    snippets = soupselect.select dom, LANG_SELECTOR
    html = """
      <hr>
      <h2>#{link_info.title}</h2>
      """
    for snippet, i in snippets
      code = fix_tabs dom_to_text snippet
      html += """
        <h5>Example #{i}</h5>
        <pre class="code">
        #{code}
        </pre>
        """
    done(html)

process_language_page = (done) -> 
  html = """
    <h1>CoffeeScript Examples From Rosetta Code</h1>
    """

  handler = (err, dom) ->
    links = soupselect.select dom, CATEGORY_PAGES_SELECTOR
    link_info = (link) ->
      href: link.attribs.href
      title: link.attribs.title
    links = (link_info(link) for link in links)
    task_page_handler = (link_info, done) ->
      process_task_page link_info, (new_html) ->
        html += new_html
        done()
    process_list links, task_page_handler, ->
      console.log html
      done()

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
        # return done_cb() if i == 3
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

dom_to_text = (dom) ->
  if dom.name == 'br'
    return '\n'
  s = ''
  if dom.type == 'text'
    s += dom.data
  if dom.children
    for child in dom.children
      s += dom_to_text child
  html_decode(s)

fix_tabs = (s) ->
  s.replace "\t", "TABS, REALLY?"
  
html_decode = (s) ->
  s = s.replace /&#(\d+);/g, (a, b) ->
    return ' ' if b == '160' # npbsp
    String.fromCharCode(b)
  s = s.replace /&(.*?);/g, (a, b) ->
    map =
      amp: '&'
      gt: '>'
      lt: '<'
      quot: '"'
    map[b] || "UNKNOWN CHAR #{b}"
    
process_language_page -> console.log "DONE!"
