lru_list = ->
  # This is a list supporting these operations quickly:
  #    push, shift, remove
  # We don't need random access, so we use a doubly linked list
  # to get O(1) time on the operations we do support.
  cnt = 0
  start_node = null
  end_node = null
  
  lst =
    push: (v) ->
      cnt += 1
      if cnt == 1
        node =
          v: v
          prev: null
          next: null
        start_node = node
        end_node = node
      else
        node =
          v: v
          prev: end_node
          next: null
        end_node.next = node
        end_node = node
    
    shift: ->
      cnt -= 1
      throw "error" if cnt < 0
      v = start_node.v
      if cnt == 0
        start_node = null
        end_node = null
      else
        start_node = start_node.next
        start_node.prev = null
      v
      
    remove: (node) ->
      cnt -= 1
      throw "error" if cnt < 0
      if node.prev
        node.prev.next = node.next
      else
        start_node = node.next
      if node.next
        node.next.prev = node.prev
      else
        end_node = node.prev
    
    debug: ->
      console.log '----'
      if cnt == 0
        console.log '(empty)'
      node = start_node
      while node
        console.log node.v
        node = node.next
        
    test: ->
      lst.push "hello"
      lst.push "goodbye"
      lst.debug()
      lst.shift()
      lst.debug()
      lst.shift()
      lst.debug()
      a = lst.push "a"
      b = lst.push "b"
      c = lst.push "c"
      lst.debug()
      lst.remove b
      lst.debug()
      lst.remove c
      lst.debug()
      lst.remove a
      lst.debug()
      
lru_list().test()
