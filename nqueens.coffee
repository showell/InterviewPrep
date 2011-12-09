attack = (board, pos, n, delta=1) ->
  ref = (r, c) ->
    board[n*r+c] += delta

  row = Math.floor pos / n
  col = pos % n
  for i in [0...n]
    if i != col
      ref row, i
      r1 = row + col - i
      r2 = row + i - col
      if 0 <= r1 and r1 < n
        ref r1, i
      if 0 <= r2 and r2 < n
        ref r2, i
    if i != row
      ref i, col

show = (board) ->
  for r in [0...n]
    s = ''
    for c in [0...n]
      s += "#{board[n*r+c]} "
    console.log s + "\n"

n = 8
board = []
for i in [1..n*n]
  board.push 0

queens = []
while true  
  i = 0
  while queens.length < n
    if board[i] == 0
      attack board, i, n
      queens.push i
    i += 1
    if i >= n*n
      i = queens.pop()
      attack board, i, n, -1
      i += 1
  break
console.log queens
show board