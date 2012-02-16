swap = (arr, a, b) ->
  [arr[a], arr[b]] = [arr[b], arr[a]]
      
sift_down = (h, n, max=h.length) ->
  while n < max
    biggest = n
    c1 = 2*n + 1
    c2 = c1 + 1
    if c1 < max and h[c1] > h[biggest]
      biggest = c1
    if c2 < max and h[c2] > h[biggest]
      biggest = c2
    return if biggest == n
    swap h, n, biggest
    n = biggest

heapify = (h) ->
  m = h.length / 2 - 1
  m = Math.floor m
  while m >= 0
    sift_down h, m
    m -= 1
    
sort = (h) ->
  heapify(h)
  end = h.length - 1
  while end > 0
    swap h, 0, end
    sift_down h, 0, end
    end -= 1

do ->
  arr = [12, 11, 10, 9, 1, 2, 3, 4, 5, 6, 7, 8]
  sort arr
  console.log arr
