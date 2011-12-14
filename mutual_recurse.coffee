F = (n) ->
  return 1 if n == 0
  n - M F(n-1)

M = (n) ->
  return 0 if n == 0
  n - F M(n-1)
 
console.log (F(n) for n in [0...20])
console.log (M(n) for n in [0...20])