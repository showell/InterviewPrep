print_power_sets = (arr) ->
  console.log "POWER SET of #{arr}"
  binary = (false for elem in arr)
  power_set = []
  n = arr.length
  output = ->
    power_set = (arr[i] for i of binary when binary[i])
    console.log power_set
  while binary.length <= arr.length
    output()
    i = 0
    while true
      if binary[i]
        binary[i] = false
        i += 1
      else
        binary[i] = true
        break
    binary[i] = true
      
print_power_sets []XXXXX
print_power_sets ['singleton'] 
print_power_sets ['dog', 'c', 'b', 'a']