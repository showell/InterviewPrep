# configure these for your language
module.exports =
  LANGUAGE: 'CoffeeScript'
  LANGUAGE_WEBSITE: "http://coffeescript.org"
  LANG_SELECTOR: 'pre.coffeescript.highlighted_source'
  BLACKLIST: (title) ->
    # These are programs that just don't add a lot of value out of context,
    # or that have distracting style issues.
    return true if title in [
      '24 game' # whitespace
      '99 Bottles of Beer' # strange
      '100 doors'
      'A+B'
      'Comments'
      'CSV to HTML translation'
      'Empty program'
      'First-class functions' # for now
      'Infinity'
      'Permutations' # whitespace
      'Quine'
    ]
    return true if title.match /Hello world/
    return true if title.match /Loops\//
    return true if title.match /Vigen.* cipher/ # unicode
    false
  
