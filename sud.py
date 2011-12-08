def ok_horizontal(m):
  # for each horizontal row in the array, ensure
  # that you dont have duplicate values
  for lst in m:
    # TODO, just use set
    vals = {} # values encountered so far
    for elem in lst:
      if elem is None:
        continue
      if elem in vals:
        return False
      else:
        vals[elem] = True
  return True


def ok_vertical(m):
  for i in range(len(m[0])):
    vals = {}
    for lst in m:
      elem = lst[i]
      if elem is None:
        continue
      if elem in vals:
        return False
      else:
        vals[elem] = True
  return True

def ok_box(m, x, y, w):
  vals = {}
  for i in range(w):
    for j in range(w):
      elem = m[x+i][y+j]
      if elem is not None:
        if elem in vals:
          return False
        else:
          vals[elem] = True
  return True

  
def ok_boxes(m, w):
  for i in range(w):
    for j in range(w):
      ok = ok_box(m, i*w, j*w, w)
      if !ok: return False
  return True
  
def ok_suduko(m, w=3):
    return ok_horizontal(m) and ok_vertical(m) and ok_boxes(m,w)
    
