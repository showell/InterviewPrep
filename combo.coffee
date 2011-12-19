combinations = (n, p) ->
  return [ [] ] if p == 0
  i = 0
  combos = []
  combo = []
  while true
    if i >= n
      break if combo.length == 0
      i = combo.pop() + 1
    else
      combo.push i
      if combo.length == p
        combos.push clone combo
        i = combo.pop() + 1
      else
        i += 1
  combos
    
clone = (arr) -> (n for n in arr)

N = 3
for i in [0..N]
  console.log "------ #{N} #{i}"
  for combo in combinations N, i
    console.log combo
    