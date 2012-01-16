max_truncatable_number = (n, f) ->
  if n < 10
    candidate = n 
    while candidate > 0
      return candidate if f(candidate)
      candidate -= 1
  else
    left = Math.floor n / 10
    right = n % 10
    while left > 0
      left = max_truncatable_number left, f
      while right > 0
        candidate = left * 10 + right
        return candidate if f(candidate)
        right -= 1
      left -= 1
      
is_prime = (n) ->
  return false if n == 1
  return true if n == 2
  for d in [2..n]
    return false if n % d == 0
    return true if d * d >= n

    
console.log max_truncatable_number 99, is_prime