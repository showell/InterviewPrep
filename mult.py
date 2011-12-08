def mult(a):
  r = [1]
  n = 1
  for i in a:
    n *= i
    r.append(n)
  l = [1]
  n = 1
  for j in reversed(a):
    n *= j
    l.append(n)
  print r
  print l
  for i in range(len(a)):
    print r[i] * l[len(a)-i-1]
    

a = [1,2,3,4,5,6]
mult(a)
  