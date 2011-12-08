
def traverse(tree):
  i = 0
  q = []
  q.append(tree)
  while i < len(q):
    val, children = q[i]
    i += 1
    print val
    if children:
      q += children

tree = (
  1,
  [(2, [(6, None)]), (3, None), (4, None), (5, None)]
)
  
traverse(tree)