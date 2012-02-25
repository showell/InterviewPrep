print_odd_squares_until_overflow = (iterator) ->
  console.log "-- Squares:"
  # it would be nice to sugar the next six lines                  
  loop
    try
      val = iterator()
    catch e
      break if e is "StopIteration"
      throw e
    sq = val * val
    continue if sq % 2 == 0
    break if sq > 500
    console.log sq
  return

do ->
  range_iterator = (low, high) ->
    i = low - 1
    ->
      i += 1
      throw "StopIteration" if i > high
      i

  iterator = range_iterator(1, 25)
  print_odd_squares_until_overflow iterator

do ->
  natural_numbers = ->
    # infinite iterator
    i = 0
    ->
      val = i
      i += 1
      val
    
  iterator = natural_numbers()
  print_odd_squares_until_overflow iterator