max_right_truncatable_number = (n, f) ->
  left = Math.floor n / 10
  right = n % 10
  while left > 0
    left = max_right_truncatable_number left, f
    while right > 0
      candidate = left * 10 + right
      return candidate if f(candidate)
      right -= 1
    left -= 1
    right = 9
      
is_prime = (n) ->
  return false if n == 1
  return true if n == 2
  for d in [2..n]
    return false if n % d == 0
    return true if d * d >= n

    
console.log max_right_truncatable_number 999999, is_prime