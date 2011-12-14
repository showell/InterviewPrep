def doubler():
  while True:
    val = (yield)
    print("double", val*2)

def count(target, max):
  i = 0
  next(target)
  while i < max:
    target.send(i)
    i += 1
  target.close()

def foo123():
  yield 1
  yield 2
  yield 3
  
for m in foo123():
  count(doubler(), m)
  print('---')