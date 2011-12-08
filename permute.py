def permute(n):
  def k(a):
    # returns index of array preceding longest
    # string of descending values
    k = len(a) - 2
    while k >= 0:
      if a[k] < a[k+1]:
        return k
      k -= 1
    return k

  def l(a, value):
    # return greatest index greater than value
    l = len(a) - 1
    while l >= 0:
      if a[l] > value:
        return l
      l -= 1
    return l

  def swap(a, i, j):
    a[i], a[j] = a[j], a[i]

  def fliptail(a, i):
    # flip all values from index i to the end
    j = len(a) - 1
    while i < j:
      swap(a, i, j)
      i += 1
      j -= 1

  def succ(a):
    # modifies a so that it is it's permutation successor
    kk = k(a)
    if kk < 0:
      return False
    ll = l(a, a[kk])
    swap(a, kk, ll)
    fliptail(a, kk+1)
    return True
    
  a = range(0, n)
  print a
  while succ(a):
    print a
  
permute(3)