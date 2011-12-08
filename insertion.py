def promote(a, i):
  v = a[i]
  i -= 1
  while i >= 0:
    if a[i] > v:
     a[i+1] = a[i]
    else:
      break
    i -= 1
  a[i+1] = v

def insertion_sort(a):
  i = 1
  while i < len(a):
    promote(a, i)
    i += 1

a = [2,4,0,6,8, 1,3,5,7,9, 10, 11,15,14,13,12, 16]
insertion_sort(a)
print a