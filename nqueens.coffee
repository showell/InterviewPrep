nqueens = (n) ->
  neighbors = precompute_neighbors(n)

  board = []
  num_solutions = 0
  num_backtracks = 0
  queens = []
  pos = 0

  for p in [0...n*n]
    board.push 0
  
  attack = (pos, delta=1) ->
    for neighbor in neighbors[pos]
      board[neighbor] += delta
      
  backtrack = ->
    pos = queens.pop()
    attack pos, -1 # unattack queen you just pulled
    pos += 1
    num_backtracks += 1

  # The following loop finds all 92 solutions to 
  # the 8-queens problem (for n=8).
  while true  
    if pos >= n*n
      if queens.length == 0
        break
      backtrack()
      continue

    # If a square is empty
    if board[pos] == 0
      attack pos
      queens.push pos
      if queens.length == n
        num_solutions += 1
        show_queens queens, n
        backtrack()
    pos += 1
    
  console.log "#{num_solutions} solutions"
  console.log "#{num_backtracks} backtracks"


precompute_neighbors = (n) ->
  # For each board position, build a list of all
  # the board positions that would be under attack if
  # you placed a queen on it.  This assumes a 1d array
  # of squares.
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
  neighbors


show_queens = (queens, n) ->
  # precondition: queens is a sorted array of integers,
  # and each row is represented
  console.log "\n------"
  for q in queens
    col = q % n
    s = ''
    for c in [0...n]
      if c == col
        s += "Q "
      else
        s += "* "
    console.log s + "\n"

nqueens(8)