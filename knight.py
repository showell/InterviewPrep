def reflect(p):
  x, y = p
  if x > 3:
    x = 7 - x
  if y > 3:
    y = 7 - y
  if y > x:
    [x, y] = [y, x]
  return [x,y]
  
def flat(p):
  x, y = p
  if x == 0:
    return y
  elif x == 1:
    return y+1
  elif x == 2:
    return y+3
  else:
    return y+6
  
def moves(p):
  deltas = [
    [1, 2],
    [1, -2],
    [2, 1],
    [2, -1],
    [-1, 2],
    [-1, -2],
    [-2, 1],
    [-2, -1],
  ]
  [x, y] = p
  for dx, dy in deltas:
    [i, j] = reflect([x+dx, y+dy])
    if i >= 0 and j >= 0:
      print flat([i, j])
  print '---'

for i in range(4):
  for j in range(0, i+1):
    print [i,j], flat([i,j])
    print ':'
    moves([i,j])
