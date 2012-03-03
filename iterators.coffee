print_odd_squares_until_overflow = (iterator) ->
  console.log "-- Squares:"
  # it would be nice to sugar the next three lines                  
  loop
    [done, val] = iterator.next()
    break if done
    sq = val * val
    break if sq > 500
    continue if sq % 2 == 0
    console.log sq
  return

box = (f) ->
  ->
    try
      val = f()
    catch e
      return [true] if e is "StopIteration"
      throw e
    [false, val]

do ->
  range_iterator = (low, high) ->
    i = low - 1
    next: box ->
      i += 1
      throw "StopIteration" if i > high
      i

  iterator = range_iterator(1, 25)
  print_odd_squares_until_overflow iterator

do ->
  natural_numbers = ->
    # infinite iterator
    i = 0
    next: box ->
      val = i
      i += 1
      val
    
  iterator = natural_numbers()
  print_odd_squares_until_overflow iterator
  
array_iterator = (arr) ->
  # turn an array into an iterator
  i = -1
  next: box ->
    i += 1
    throw "StopIteration" if i >= arr.length
    arr[i]
    
do ->
  arr = [5, 7, 8, 100, 3, 2]
  print_odd_squares_until_overflow array_iterator(arr)
  
  