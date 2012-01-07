lex = (sexp) ->
  is_whitespace = (c) -> c in [' ', '\t', '\n']
  i = 0
  tokens = []
  
  test = (f) ->
    return false unless i < sexp.length
    f(sexp[i])
  
  eat_char = (c) ->
    tokens.push c
    i += 1

  eat_whitespace = ->
    i += 1
    while test is_whitespace
      i += 1
    tokens.push ' '

  eat_word = ->
    token = c
    i += 1
    word_char = (c) ->
      c != '(' and !is_whitespace c
    while test word_char
      token += sexp[i]
      i += 1
    tokens.push token
  
  eat_quoted_word = ->
    start = i
    i += 1
    token = ''
    while test ((c) -> c != '"')
      if sexp[i] == '\\'
        i += 1
        throw Error("escaping error") unless i < sexp.length
      token += sexp[i]
      i += 1
    if test ((c) -> c == '"')
      tokens.push token
      i += 1
    else
      throw Error("end quote missing #{sexp.substring(start, i)}")
  
  while i < sexp.length
    c = sexp[i]
    if c == '(' or c == ')'
      eat_char c
    else if is_whitespace c
      eat_whitespace()
    else if c == '"'
      eat_quoted_word()
    else
      eat_word()
  tokens


test = """
  ((data "quoted data with escaped \\"" 123 4.5)
   (data (!@# (4.5) "(more" "data)")))
"""
console.log lex(test)