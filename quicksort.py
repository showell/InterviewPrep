def quicksort(a):
  def swap(a, i, j):
    if i == j:
      return
    a[i], a[j] = a[j], a[i]

  def divide(a, v, start, end):
    first_big = start
    j = start
    while j <= end:
      if a[j] < v:
        swap(a, first_big, j)
        first_big += 1
      j += 1
    return first_big

  def partition(a, start, end):
    v = a[end]
    first_big = divide(a, v, start, end-1)
    swap(a, first_big, end)
    return first_big

  def qs(a, start, end):
    if start >= end:
      return
    m = partition(a, start, end)
    qs(a, start, m-1)
    qs(a, m+1, end)

  qs(a, 0, len(a) - 1)

a = [1, 3, 5, 7, 9, 8, 6, 4, 2, 0, 3.5]
#    0  1  2  3  4  5  6  7  8  9  10
quicksort(a)
print a

a = [0]
quicksort(a)
print a