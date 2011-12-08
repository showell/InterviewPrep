def find(x, arr):

  def search(lower, upper):
    if lower >= upper:
      return -1
    mid = (lower + upper) // 2
    if x < arr[mid]:
      return search(lower, mid)
    elif arr[mid] == x:
      return mid
    else:
      return search(mid+1, upper)
      
  return search(0, len(arr))
  
print find(5, [1, 3, 5, 7])