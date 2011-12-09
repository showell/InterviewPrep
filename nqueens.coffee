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

show = (board, n) ->
  console.log "\n------"
  for r in [0...n]
    s = ''
    for c in [0...n]
      if board[n*r+c] == 0
        s += "Q "
      else
        s += ". "
    console.log s + "\n"

nqueens = (n) ->
  num_solutions = 0
  num_backtracks = 0
  
  board = []
  for i in [1..n*n]
    board.push 0

  queens = []
  
  pos = 0
  backtrack = ->
    pos = queens.pop()
    attack board, pos, n, -1
    pos += 1
    num_backtracks += 1

  while true  
    if pos >= n*n
      if queens.length == 0
        break
      backtrack()
      continue

    if board[pos] == 0
      attack board, pos, n
      queens.push pos
      if queens.length == n
        num_solutions += 1
        show board, n
        backtrack()
    pos += 1
    
  console.log "#{num_solutions} solutions"
  console.log "#{num_backtracks} backtracks"

nqueens(8)