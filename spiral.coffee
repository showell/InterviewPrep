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
  edge_run =
    N: -> x - y
    E: -> 1 * (inner_square_edge - 1) + y - edge_offset
    S: -> 2 * (inner_square_edge - 1) + y - x
    W: -> 3 * (inner_square_edge - 1) + edge_offsets.S - x

  upper_left_offset = n * n - inner_square_edge * inner_square_edge
  upper_left_offset + edge_run[border]()
  
spiral_matrix = (n) ->
  arr = []
  for y in [0...n]
    arr.push (spiral_value x, y, n for x in [0...n])
  arr
  
do ->
  for n in [6, 7]
    console.log "\n----Spiral n=#{n}"
    console.log spiral_matrix n