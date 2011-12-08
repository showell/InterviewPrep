def get_factorials(n):
  ans = [1]
  i = 1
  f = 1
  while i <= n:
    f *= i
    ans.append(f)
    i += 1
  return ans

def permutation(a, i, factorials):
  ans = []
  while len(a) > 0:
    f = factorials[len(a)-1]
    n = i / f
    i = i % f
    ans.append(a[n])
    a = a[0:n] + a[n+1:len(a)]
  return ans
  
n = 6
factorials = get_factorials(n)
for i in range(factorials[n]):
  print i, permutation(range(n), i, factorials)
  
