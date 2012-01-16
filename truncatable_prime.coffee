# You could have symmetric algorithms for max right and left
# truncatable numbers, but they lend themselves to slightly
# different optimizations.

max_right_truncatable_number = (n, f) ->
  # This algorithm only evaluates 37 numbers for primeness to
  # get the max right truncatable prime < 1000000.
  if n < 10
    max_digit n, f
  else
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
      
# max_left_truncatable_number = (n, f) ->
#   
   
max_digit = (n, f) ->
  # return max digit <= n where fn(fn) is true
  candidate = n 
  while candidate > 0
    return candidate if f(candidate)
    candidate -= 1
  
is_prime = (n) ->
  return false if n == 1
  return true if n == 2
  for d in [2..n]
    return false if n % d == 0
    return true if d * d >= n

    
console.log max_right_truncatable_number 999999, is_prime