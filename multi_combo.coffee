combos = (arr, k) ->
  if k == 1
    return ([elem] for elem in arr)

  head = arr[0]
  if arr.length == 1
    return [ (head for i in [0...k]) ]
    
  combos_with_head = ([head].concat combo for combo in combos arr, k-1)
  combos_sans_head = combos arr[1...], k
  combos_with_head.concat combos_sans_head
  
arr = ['iced', 'jam', 'plain']
console.log "valid pairs from #{arr.join ','}:"
console.log combos arr, 2
console.log "#{combos([1..10], 3).length} ways to order 3 donuts given 10 types"
    