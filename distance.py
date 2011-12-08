def f(lst):
  n = len(lst)
  coords = [0] * n
  while True:
    tup = [lst[i][coords[i]] for i in range(n)]
    print tup
    next_tuple = None
    for i in range(n):
      if coords[i] + 1 < len(lst[i]):
        my_tuple = (lst[i][coords[i] + 1], i)
        if next_tuple is None:
          next_tuple = my_tuple
        elif my_tuple < next_tuple:
          next_tuple = my_tuple
    if next_tuple is None:
      break
    i = next_tuple[1]
    coords[i] += 1


a = [1, 100, 101, 150, 1000]
b = [40, 50, 60, 104, 170, 500, 1001]
c = [90, 143, 161, 499, 999]
lst = [a, b, c]
f(lst)

