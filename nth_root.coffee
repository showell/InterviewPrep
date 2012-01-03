nth_root = (A, n, iterations) ->
  x = 1
  for i in [1..iterations]
    x = (1 / n) * ((n - 1) * x + A / Math.pow(x, n - 1))
  x

# tests
do ->  
  for x in [4, 8, 16, 32, 1000, 1000000]
    for n in [2..6]
      iterations = n * 10 # big roots converge slowly
      root = nth_root x, n, iterations
      console.log "#{x} root #{n} = #{root} (root^#{n} = #{Math.pow root, n})"
    console.log "--"