print_odd_squares_until_overflow = (iterator) ->
  console.log "-- Squares:"
  # it would be nice to sugar the next six lines                  
  loop
    try
      val = iterator.next()
    catch e
      break if e is "StopIteration"
      throw e
    sq = val * val
    break if sq > 500
    continue if sq % 2 == 0
    console.log sq
  return

do ->
  range_iterator = (low, high) ->
    i = low - 1
    next: ->
      i += 1
      throw "StopIteration" if i > high
      i

  iterator = range_iterator(1, 25)
  print_odd_squares_until_overflow iterator

do ->
  natural_numbers = ->
    # infinite iterator
    i = 0
    next: ->
      val = i
      i += 1
      val
    
  iterator = natural_numbers()
  print_odd_squares_until_overflow iterator
  
array_iterator = (arr) ->
  # turn an array into an iterator
  i = -1
  next: ->
    i += 1
    throw "StopIteration" if i >= arr.length
    arr[i]
    
do ->
  arr = [5, 7, 8, 100, 3, 2]
  print_odd_squares_until_overflow array_iterator(arr)
  
  