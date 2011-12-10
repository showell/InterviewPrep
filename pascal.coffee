# Artificial constraint: do this in O(N) space).

pascal = (n) ->
  # how to mutate row:
  # 1  2   1
  # 1  2   1  (1)  push
  # 1  2  (3)  1   2+1
  # 1 (3)  3   1   1+2
  row = []
  for r in [1..n]
    row.push 1
    s = ws 3*(n-r)
    c = r - 2
    while c >= 1
      row[c] = row[c-1] + row[c]
      c -= 1
    for c in [0...r]
      s += pad 6, "#{row[c]}"
    console.log s

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

pascal(15)
