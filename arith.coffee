reduce_rule = (stack, rule) ->
  tokenizer = rule[0]
  offset = stack.length - tokenizer.length
  return false if offset < 0
  for i in [0...tokenizer.length]
    expected = tokenizer[i]
    actual = stack[offset+i][0]
    return false if expected != actual
  f = rule[1]
  val = f(stack[offset...stack.length])
  stack.splice offset, tokenizer.length, val...
  true
    

stack = [
  ['('],
  ['('],
  ['expr', 5],
  [')'],
]

reduce = (stack) ->
  rules = []
  rule = (tokenizer, f) -> rules.push [tokenizer, f]

  rule ['(', 'expr', ')'], (expr) ->
      [ expr[1] ]
  
  for rule in rules
    reduce_rule stack, rule

reduce stack
stack.push [')']
console.log stack
reduce stack
console.log stack