graph_tour = (graph) ->
  # graph is an array of arrays
  # graph[3] = [4, 5] means nodes 4 and 5 are reachable from node 3
  visited = (false for node in graph)
  dead_ends = ({} for node in graph)
  tour = [0]
  
  next_square_to_visit = (i) ->
    for neighbor in graph[i]
      continue if visited[neighbor]
      continue if dead_ends[i][neighbor]
      return neighbor
    return null
  
  backtracks = 0
  while true
    current_square = tour[tour.length - 1]
    visited[current_square] = true
    next_square = next_square_to_visit current_square
    if next_square?
      tour.push next_square
      break if tour.length == graph.length - 3
      # pessimistically call this a dead end
      dead_ends[current_square][next_square] = true
      current_square = next_square
    else
      # we backtrack
      doomed_square = tour.pop()
      dead_ends[doomed_square] = {}
      visited[doomed_square] = false
      backtracks += 1
  tour
  

knight_graph = (board_width) ->
  # Turn the Knight's Tour into a pure graph-traversal problem
  # by precomputing all the legal moves.  Returns an array of arrays,
  # where each element in any subarray is the index of a reachable node.
  index = (i, j) ->
    # index squares from 0 to n*n - 1
    board_width * i + j
  
  reachable_squares = (i, j) ->
    deltas = [
      [ 1,  2]
      [ 1, -2]
      [ 2,  1]
      [ 2, -1]
      [-1,  2]
      [-1, -2]
      [-2,  1]
      [-2, -1]
    ]
    neighbors = []
    for delta in deltas
      [di, dj] = delta
      ii = i + di
      jj = j + dj
      if 0 <= ii < board_width
        if 0 <= jj < board_width
          neighbors.push index(ii, jj)
    neighbors
  
  graph = []
  for i in [0...board_width]
    for j in [0...board_width] 
      graph[index(i, j)] = reachable_squares i, j
  graph
  
illustrate_knights_tour = (tour, board_width) ->
  pad = (n) ->
    return " _" if !n?
    return " " + n if n < 10
    "#{n}"
    
  moves = {}
  for square, i in tour  
    moves[square] = i + 1
  for i in [0...board_width]
    s = ''
    for j in [0...board_width]
      s += "  " + pad moves[i*board_width + j]
    console.log s
  
  
BOARD_WIDTH = 8
graph = knight_graph BOARD_WIDTH
tour = graph_tour graph
illustrate_knights_tour tour, BOARD_WIDTH