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

do ->
  box = (f) ->
    ->
      try
        val = f()
      catch e
        return [true] if e is "StopIteration"
        throw e
      [false, val]

  # create our iterator using Python style, but then use "box"
  # so that the caller doesn't see exceptions
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
    # infinite iterator, and we do our own boxing
    i = 0
    next: ->
      val = i
      i += 1
      [false, val]
    
  iterator = natural_numbers()
  print_odd_squares_until_overflow iterator
  
array_iterator = (arr) ->
  # turn an array into an iterator that supports
  # the "boxing" protocol
  i = -1
  next: ->
    i += 1
    return [true] if i >= arr.length
    [false, arr[i]]
    
do ->
  arr = [5, 7, 8, 100, 3, 2]
  print_odd_squares_until_overflow array_iterator(arr)
  
  