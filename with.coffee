class Wrap:
  def __init__(self, obj):
    self.obj = obj
  def __enter__(self):
    self.obj.enter()
  def __exit__(self, *args):
    self.obj.exit(*args)

class Bucket:
  pass

foo = Bucket()
foo.name = "Steve"
foo.enter = lambda: print("hello")
foo.exit = lambda *args: print("goodbye")

with Wrap(foo):
  print("doing stuff")