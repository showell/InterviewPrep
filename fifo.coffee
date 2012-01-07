# Implement a fifo as an array of arrays, to
# greatly amortize dequeues, at some expense of
# memory overhead and insertion time.
Fifo = ->
  max_chunk = 4000
  arr = []
  count = 0
  curr = -1
  head = 0

  self =
    enqueue: (elem) ->
      if count == 0 or arr[curr].length >= max_chunk
        arr.push []
        curr += 1
      count += 1
      arr[curr].push elem
    dequeue: (elem) ->
      throw Error("queue is empty") if count == 0
      val = arr[0][head]
      head += 1
      count -= 1
      if head >= arr[0].length
        arr.shift()
        head = 0
      val
    is_empty: (elem) ->
      count == 0

# test
do ->
  max = 1000*1000
  q = Fifo()
  for i in [1..max]
    q.enqueue
      number: i

  console.log q.dequeue()
  while !q.is_empty()
    v = q.dequeue()
  console.log v
