import random
import os
import glob

class Memory:
    def __init__(self):
        self.cnt = 0

    def alloc(self, cnt):
        self.cnt += cnt

    def free(self, cnt):
        self.cnt -= cnt
memory = Memory()

class OrderAssurer:
    def __init__(self):
        self.prev = None

    def visit(self, item):
        if self.prev:
            if self.prev > item:
                raise Exception('sort is broken')
        self.prev = item

class DiskList:
    def __init__(self, fn, elements):
        self.mem = memory
        self.fn = fn
        self.cnt = len(elements)
        if self.cnt > 0:
            self.head = elements[0]
        self.cache = []
        f = open(self.fn, 'w')
        for item in elements:
            f.write(str(item) + '\n')
        f.close()

    def append(self, item):
        if self.cnt == 0:
            self.head = item
        self.cnt += 1
        self.mem.alloc(1)
        self.cache.append(item)
        if len(self.cache) + self.mem.cnt > 500000:
            self.flush()

    def flush(self):
        f = open(self.fn, 'a')
        for item in self.cache:
            f.write(str(item) + '\n')
        f.close()
        cnt = len(self.cache)
        self.mem.free(cnt)
        self.cache = []

    def elements(self):
        self.flush()
        fn = self.fn
        elements = [int(line.strip()) for line in open(fn)]
        return elements
    
    def close(self):
        fn = self.fn
        os.remove(fn)

class Storage:
    def __init__(self):
        for fn in glob.glob('/tmp/foo*'):
            os.remove(fn)
        self.n = 0

    def get_fn(self):
        self.n += 1
        fn = "/tmp/foo_{n}".format(n = self.n)
        return fn

def make_root_tree(max, storage):
    return make_tree(max, storage, [])

class Record:
    pass

def make_tree(max, storage, elements):
    fn = storage.get_fn()
    lst = DiskList(fn, elements)
    rec = Record()
    rec.storage = storage
    rec.children = False
    rec.max = max
    rec.lst = lst
    return rec

def add_to_tree(tree, item):
    if tree.children:
        tree.lst.append(item)
    else:
        add_to_simple_tree(tree, item)

def get_position(children, item):
    last = len(children) - 1
    for i in range(last):
        child = children[i+1]
        head = child.lst.head
        if item < head:
            return i
    return last

class BranchList:
    def __init__(self, items, head, cnt, fn):
        self.items = items
        self.head = head
        self.cnt = cnt
        self.fn = fn
        
    def append(self, item):
        self.cnt += 1
        children = self.items
        pos = get_position(children, item)
        add_to_tree(children[pos], item)

def add_to_simple_tree(tree, item):
    max = tree.max
    lst = tree.lst
    lst.append(item)
    cnt = lst.cnt
    if cnt >= max:
        split_tree(tree, lst, max, cnt)

def split_tree(tree, lst, max, cnt):
    elements = sorted(lst.elements())
    storage = tree.storage
    incr = (cnt + 1) // 4
    lst.close()
    children = []
    i = 0
    while i < cnt:
        child = make_tree(max, storage, elements[i:i+incr])
        children.append(child)
        i += incr
    tree.children = True
    fn = storage.get_fn()
    tree.lst = BranchList(children, lst.head, lst.cnt, fn)

def tree_visit(tree, visitor, depth = 0):
    lst = tree.lst
    if tree.children:
        print '  ' * depth, lst.cnt, lst.fn
        for idx in lst.items:
            tree_visit(idx, visitor, depth + 1)
    else:
        print '  ' * depth, lst.cnt, lst.fn
        items = lst.elements()
        items.sort()
        # print len(items), lst.fn, tree.max
        for item in items:
            visitor(item)

class Visitor:
    def __init__(self): 
        self.order_assurer = OrderAssurer()
        self.num_visited = 0

    def visit(self, item):
        self.order_assurer.visit(item)
        self.num_visited += 1

def sample_data(num_items):
    for i in range(num_items):
        n = random.randint(1, 100000)
        yield n

def test():
    storage = Storage()
    chunk_size = 5000
    num_items = 200000
    # 20 mill in 8:20
    # 5 mill in 2:00
    idx = make_root_tree(chunk_size, storage)
    for n in sample_data(num_items):
        add_to_tree(idx, n)

    visitor = Visitor()
    tree_visit(idx, visitor.visit)
    print visitor.num_visited
    print memory.cnt
    
def test_disk_list():
    dl = DiskList('/tmp/foo', [5])
    for i in range(10):
        dl.append(i)
    print dl.elements()
    print dl.cnt
    print dl.head


if __name__ == '__main__':
    test()
    # test_disk_list()

