lzw = (s) ->
  i = 0
  code_num = 256
  dct = {} # map substrings to codes between 256 and 4096
  stream = [] # array of compression results
  while i < s.length
    # Find word and new_word
    #   word = longest substr already encountered, or next character
    #   new_word = word plus next character, a new substr to encode
    word = s[i]
    j = i
    while true
      j += 1
      break if j >= s.length
      new_word = word + s[j]
      if dct[new_word]
        word = new_word
      else
        break

    # stream out the compressed substring
    if word.length == 1
      # no compression yet, just spit the character
      stream.push word
    else
      stream.push dct[word]
      
    # build up our encoding dictionary
    if code_num < 4096
      dct[new_word] = code_num
      code_num += 1
    
    # advance thru the string
    i += word.length
  stream
    
console.log lzw "TOBEORNOTTOBEORTOBEORNOT"
