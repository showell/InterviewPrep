class WithWrapper:
  def __init__(self, obj):
    self.obj = obj
  def __enter__(self):
    self.obj['enter']()
  def __exit__(self, *args):
    self.obj['exit'](*args)

def greeter_context(hello, goodbye):
  return {
    'enter': lambda: print("---\n" + hello),
    'exit': lambda *args: print(goodbye)
  }
  
gc_french = greeter_context("salut", "a plus tard")
  
with WithWrapper(gc_french):
  print("doing stuff")
  
gc_slang = greeter_context("yo", "later")
with WithWrapper(gc_slang):
  print("doing stuff")