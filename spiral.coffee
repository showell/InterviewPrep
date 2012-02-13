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
      
  inner_square_size = n - 2 * edge_offset
  edge_run =
    N: -> x - edge_offset
    E: -> inner_square_size + y - edge_offset - 1
    S: -> 3 * inner_square_size - x + edge_offset - 3
    W: -> 4 * inner_square_size - y + edge_offset - 4

  upper_left_offset = n * n - inner_square_size * inner_square_size
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