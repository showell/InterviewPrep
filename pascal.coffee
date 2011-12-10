# Artificial constraint: do this in O(N) space).

pascal = (n) ->
  width = 6
  parent_row = []
  for r in [1..n]
    row = [0] # for convenience
    
    # get values from parent cells
    for c in [0...r-1]
      row.push parent_row[c] + parent_row[c+1]
    row.push 1

    s = ws (width/2) * (n-r)
    for c in [1..r]
      s += pad width, "#{row[c]}"
    
    console.log s
    parent_row = row

ws = (n) ->
  s = ''
  s += ' ' for i in [0...n]
  s

pad = (cnt, s) ->
  # There is probably a better way to do this.
  cnt -= s.length
  right = Math.floor(cnt / 2)
  left = cnt - right
  ws(left) + s + ws(right)

pascal(10)
