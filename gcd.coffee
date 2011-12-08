gcd = (x, y) ->
  return x if y == 0
  gcd(y, x % y)
  
console.log gcd(25, 18)