spiral_value = (x, y, n) ->
  prior_legs =
    N: 0
    E: 1
    S: 2
    W: 3

  edge_run = (edge_offset) ->
    N: -> edge_offset.W - edge_offset.N
    E: -> edge_offset.N - edge_offset.E
    S: -> edge_offset.E - edge_offset.S
    W: -> edge_offset.S - edge_offset.W

  edge_offset =
    N: y
    E: n - 1 - x
    S: n - 1 - y
    W: x
    
  min_edge_offset = n
  for dir of edge_offset
    if edge_offset[dir] < min_edge_offset
      min_edge_offset = edge_offset[dir]
      border = dir
      
  inner_square_edge = n - 2 * min_edge_offset
  upper_left_offset = n * n - inner_square_edge * inner_square_edge

  corner_offset = upper_left_offset + prior_legs[border] * (inner_square_edge - 1)
  
  corner_offset + edge_run(edge_offset)[border]()
  
spiral_matrix = (n) ->
  arr = []
  for y in [0...n]
    arr.push (spiral_value x, y, n for x in [0...n])
  arr
  
do ->
  for n in [6, 7]
    console.log "\n----Spiral n=#{n}"
    console.log spiral_matrix n