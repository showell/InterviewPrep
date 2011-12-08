# Generate hamming numbers in order.  Hamming numbers have the
# property that they don't evenly divide any prime numbers outside
# a given set, such as [2, 3, 5].

min_idx = (arr) ->
  # This is lame, but CS compiles to JS, and JS sucks at sorting 
  # arrays.  Don't waste your time reading this--it just returns
  # the index of the smallest tuple in an array, respecting that
  # the tuples may contain integers. (Also, I didn't want to introduce any 
  # dependencies.)
  less_than = (tup1, tup2) ->
    i = 0
    while i < tup2.length
      return true if tup1[i] < tup2[i]
      return false if tup1[i] > tup2[i]
      i += 1
      
  min_i = 0
  for i in [1...arr.length]
    if less_than arr[i], arr[min_i]
      min_i = i
  return min_i

next_candidate = (candidate, hamming_numbers) ->
  # This is the magic.  Let's say, over the primes [2,3,5],
  # we encounter the hamming number 32 based on it being 
  # 2 * 16, where 16 is the 12th number in the sequence.
  # We'll be passed in [32, 2, 12] as candidate, and
  # hamming_numbers will be [1,2,3,4,5,6,8,9,10,12,16,18,...]
  # by now.  The next candidate we need to enqueue is
  # [36, 2, 13], where the numbers mean this:
  #
  #    36 - next multiple of 2 of a Hamming number
  #     2 - prime number
  #    13 - 1-based index of 18 in the sequence
  # 
  # When we encounter [36, 2, 13], we will then go to
  # [40, 2, 14], based on 20 being the 14th hamming number.
  [n, p, idx] = candidate
  q = hamming_numbers[idx]
  [p*q, p, idx+1]

generate_hamming_sequence = (primes, max_n) ->
  # We use a lazy algorithm, only ever keeping N candidates
  # in play, one for each of our seed primes.  Let's say
  # primes is [2,3,5].  Our virtual streams are these:
  #
  # hammings:    1,2,3,4,5,6,8,10,12,15,16,18,20,...
  # hammings*2:  2,4,6,9.10,12,16,20,24,30,32,36,40...
  # hammings*3:  3,6,9,12,15,18,24,30,36,45,...
  # hammings*5:  5,10,15,20,25,30,40,50,...
  # After encountering 40 for the last time, our candidates 
  # will be
  #   50 = 2 * 25
  #   45 = 3 * 15
  #   50 = 5 * 10
  # Then, after 45
  #   50 = 2 * 25
  #   48 = 3 * 16 <= new
  #   50 = 5 * 10 
  hamming_numbers = [1]
  candidates = ([p, p, 1] for p in primes)
  last_number = 1
  while hamming_numbers.length < max_n
    # Get next candidate Hamming Number.
    i = min_idx(candidates)
    candidate = candidates[i]
    
    # Add to sequence unless it's a duplicate.
    [n, ignore, ignore] = candidate
    if n > last_number
      hamming_numbers.push n
      last_number = n

    # Replace the candidate with its successor:
    new_candidate = next_candidate(candidate, hamming_numbers)
    candidates[i] = new_candidate
    
  
  hamming_numbers

primes = [2, 3, 5]
numbers = generate_hamming_sequence(primes, 10000)
console.log numbers[1690]
console.log numbers[9999]

