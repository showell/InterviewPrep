spiral_value = (x, y, n) ->
  edge_offsets =
    N: y
    E: n - 1 - x
    S: n - 1 - y
    W: x
    
  edge_offset = edge_offsets.N
  border = 'N'
  for dir in ['E', 'S', 'W']
    if edge_offsets[dir] < edge_offset
      edge_offset = edge_offsets[dir]
      border = dir
      
  inner_square_edge = n - 2 * edge_offset
  upper_left_offset = n * n - inner_square_edge * inner_square_edge

  prior_legs =
    N: 0
    E: 1
    S: 2
    W: 3

  corner_offset = upper_left_offset + prior_legs[border] * (inner_square_edge - 1)
  
  edge_run =
    N: -> x - y
    E: -> y - edge_offset
    S: -> y - x
    W: -> edge_offsets.S - edge_offset

  corner_offset + edge_run[border]()
  
spiral_matrix = (n) ->
  arr = []
  for y in [0...n]
    arr.push (spiral_value x, y, n for x in [0...n])
  arr
  
do ->
  for n in [6, 7]
    console.log "\n----Spiral n=#{n}"
    console.log spiral_matrix n