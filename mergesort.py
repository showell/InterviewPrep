def merge(a, b, c):
  a_start = 0
  b_start = 0
  a_end = len(a)
  b_end = len(b)
  while True:
    if a_start >= a_end and b_start >= b_end:
      return c
    if a_start >= a_end:
      c.append(b[b_start])
      b_start += 1
    elif b_start >= b_end:
      c.append(a[a_start])
      a_start += 1
    elif a[a_start] < b[b_start]:
      c.append(a[a_start])
      a_start += 1
    else:
      c.append(b[b_start])
      b_start += 1
 
def _sort(a, a_start, a_end, target):
  if a_start + 1 == a_end:
    target.append(a[a_start])
    return
  m = (a_start + a_end) / 2
  x = []
  _sort(a, a_start, m, x)
  y = []
  _sort(a, m, a_end, y)
  merge(x, y, target)
  return target
  
def mergesort(a):
  target = []
  _sort(a, 0, len(a), target)
  return target
 
a = [0,2,4,6,8, 1,3,5,7,9, 10, 11,15,14,13,12, 16]

c = mergesort(a)
print c