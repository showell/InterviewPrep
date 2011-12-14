huffman_encoding_table = (counts) ->
  q = min_queue()
  for c, cnt of counts
    q.enqueue cnt, [c, null]
  while q.size() >= 2
    a = q.dequeue()
    b = q.dequeue()
    cnt = a.priority + b.priority
    node = [cnt, [a.metadata, b.metadata]]
    q.enqueue cnt, node
  root = q.dequeue()
  

min_queue = ->
  # This is very non-optimized; you could use a binary heap for better
  # performance.  Items with smaller priority get dequeued first.
  arr = []
  enqueue: (priority, metadata) ->
    i = 0
    while i < arr.length
      if priority < arr[i].priority
        break
      i += 1  
    arr.splice i, 0,
      priority: priority
      metadata: metadata
  dequeue: ->
    arr.shift()
  size: -> arr.length
  _internal: ->
    arr

freq_count = (s) ->
  cnts = {}
  for c in s
    cnts[c] ?= 0
    cnts[c] += 1
  cnts
  
s = "this is an example for huffman encoding"
counts = freq_count(s)
console.log JSON.stringify huffman_encoding_table counts