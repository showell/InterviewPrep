import math

n = 10000
s = 0
for i in range(0, n):
  x = i + 0.5
  m = math.sqrt(n*n-x*x)
  s += m
print (s * 4) / (n*n)
print math.pi