combo4 = (digits...) ->
  arr = for digit in digits
    {
      val: digit
      expr: digit
    }

  permutations = [
    [0, 1, 2, 3]
    [0, 2, 1, 3]
    [0, 3, 1, 2]
    [1, 2, 0, 3]
    [1, 3, 0, 2]
    [2, 3, 0, 1]
  ]
  for permutation in permutations
    [i, j, k, m] = permutation
    for rcombo in combos arr[i], arr[j]
      answer = combo3 rcombo, arr[k], arr[m]  
      return answer.expr if answer
  null

combo3 = (arr...) ->
  permutations = [
    [0, 1, 2]
    [1, 0, 2]
    [2, 0, 1]
  ]
  for permutation in permutations
    [i, j, k] = permutation
    for rcombo in combos arr[j], arr[k]
      for combo in combos arr[i], rcombo
        return combo if combo.val == 24
  null

combos = (a, b) ->
  [
    val: a.val + b.val
    expr: "(#{a.expr} + #{b.expr})"
  ,
    val: a.val * b.val
    expr: "(#{a.expr} * #{b.expr})"
  ,
    val: a.val - b.val
    expr: "(#{a.expr} - #{b.expr})"
  ,
    val: b.val - a.val
    expr: "(#{b.expr} - #{a.expr})"
  ,
    val: a.val / b.val
    expr: "(#{a.expr} / #{b.expr})"
  ,
    val: b.val / a.val
    expr: "(#{b.expr} / #{a.expr})"
  ,
  ]
  
# test
do ->
  rand_digit = -> 1 + Math.floor (9 * Math.random())

  for i in [1..15]
    a = rand_digit()
    b = rand_digit()
    c = rand_digit()
    d = rand_digit()
    solution = combo4 a, b, c, d
    console.log "Solution for #{[a,b,c,d]}: #{solution ? 'no solution'}"
