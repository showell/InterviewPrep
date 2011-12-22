random_brackets = (n) ->
  open = closed = n
  s = ''
  while open + closed > 0
    if Math.random() < open / (open + closed)
      s += '['
      open -= 1
    else
      s += ']'
      closed -= 1
  s
  
is_balanced = (s) ->
  num_open = 0
  for c in s
    return false if num_open < 0
    num_open +=
      if c == '['
      then 1
      else -1
  num_open == 0
  
n = 3
for i in [1..10]
  s = random_brackets n
  console.log s, is_balanced s