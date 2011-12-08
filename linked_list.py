# Linked list on top of a Python list.
#

def traverse(lst, head, f):
  p = head
  while p is not None:
    node = lst[p]
    val, p, ignore = node
    f(val)    

def set_next(lst, p, next):
  v, ignore, prev = lst[p]
  lst[p] = (v, next, prev)
  
def set_prev(lst, p, prev):
  v, next, ignore = lst[p]
  lst[p] = (v, next, prev)
  

def insert_after(lst, p, new_v):
  v, next, prev = lst[p]
  new = len(lst)
  set_next(lst, p, new)
  if next is not None:
    set_prev(lst, next, len(lst))
  lst.append( (new_v, next, p) )
  return new

def insert_before(lst, p, new_v):
  v, next, prev = lst[p]
  new = len(lst)
  set_prev(lst, p, new)
  if prev is not None:
    set_next(lst, prev, len(lst))
  lst.append( (new_v, p, prev) )
  return new

def insert_front(lst, new_v):
  return insert_after(lst, 0, new_v)
  
######

def output(x):
  print x
  
lst = [('HEAD', 1, None), ('apple', 3, 0), ('dog', None, 3), ('cherry', 2, 1)]

def before(a, b):
  return a < b

insert_after(lst, 1, 'banana')
insert_before(lst, 1, 'TOP')
first = insert_front(lst, 'TIPPY-TOP')

traverse(lst, first, output)
