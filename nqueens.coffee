nqueens = (n) ->
  neighbors = []

  find_neighbors = (pos) ->
    arr = []
    row = Math.floor pos / n
    col = pos % n
    for i in [0...n]
      if i != col
        arr.push row*n + i
        r1 = row + col - i
        r2 = row + i - col
        if 0 <= r1 and r1 < n
          arr.push r1*n + i
        if 0 <= r2 and r2 < n
          arr.push r2*n + i
      if i != row
        arr.push i*n + col
    arr

  for pos in [0...n*n]
    neighbors.push find_neighbors(pos) 

  board = []
  for pos in [0...n*n]
    board.push 0
  
  attack = (pos, delta=1) ->
    for neighbor in neighbors[pos]
      board[neighbor] += delta
    
  num_solutions = 0
  num_backtracks = 0

  queens = []
  
  pos = 0
  backtrack = ->
    pos = queens.pop()
    attack pos, -1
    pos += 1
    num_backtracks += 1

  while true  
    if pos >= n*n
      if queens.length == 0
        break
      backtrack()
      continue

    if board[pos] == 0
      attack pos
      queens.push pos
      if queens.length == n
        num_solutions += 1
        show board, n
        backtrack()
    pos += 1
    
  console.log "#{num_solutions} solutions"
  console.log "#{num_backtracks} backtracks"

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

nqueens(8)