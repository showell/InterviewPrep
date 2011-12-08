def max_swing(points):
  # Find max profit in O(N) time using our Time Machine.  
  # For any day, we can find the max price for the future,
  # and the min price in the past. Then we find the day where
  # we have the best delta between best possible buying price
  # and best possible selling price.  We don't optimize out
  # points that are clearly "middle" days, since it doesn't
  # reduce the overall O(N) running time.
  
  if len(points) == 0:
    return 0
    
  minv = points[0]
  mins = []
  for v in points:
    if v < minv:
      minv = v
    mins.append(minv)

  upsides = reversed(points)

  maxv = upsides.next()
  maxs = [maxv]
  for v in upsides:
    if v > maxv:
      maxv = v
    maxs.append(maxv)
  maxs.reverse()
  
  deltas = (max - min for min, max in zip(mins, maxs))
  print max(deltas)

a = [10, 30, 3500, 40, 50, 60, 0, -1000, 2000]
print a
max_swing(a)