import random
import os
import glob

class DiskList:
    def __init__(self, fn, elements):
        self.fn = fn
        self.cnt = len(elements)
        if self.cnt > 0:
            self.head = elements[0]
        self.cache = elements
        f = open(self.fn, 'w')
        f.close()
        self.flush()

    def append(self, item):
        if self.cnt == 0:
            self.head = item
        self.cnt += 1
        self.cache.append(item)

    def flush(self):
        f = open(self.fn, 'a')
        for item in self.cache:
            f.write(str(item) + '\n')
        f.close()
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
    def __init__(self, items):
        self.items = items
        self.head = items[0].lst.head
        
    def append(self, item):
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
    m = (cnt + 1) // 2
    storage = tree.storage
    lst.close()
    tree_0 = make_tree(max, storage, elements[0:m])
    tree_1 = make_tree(max, storage, elements[m:cnt])
    tree.children = True
    tree.lst = BranchList([tree_0, tree_1])

def tree_visit(tree, visitor):
    lst = tree.lst
    if tree.children:
        for idx in lst.items:
            tree_visit(idx, visitor)
    else:
        items = lst.elements()
        items.sort()
        print len(items), lst.fn, tree.max
        for item in items:
            visitor(item)

class OrderAssurer:
    def __init__(self):
        self.prev = None

    def visit(self, item):
        if self.prev:
            if self.prev > item:
                raise Exception('sort is broken')
        self.prev = item

def make_visitor():
    order_assurer = OrderAssurer()
    def visit(item):
        order_assurer.visit(item)
    return visit

def sample_data(num_items):
    for i in range(num_items):
        n = random.randint(1, 100000)
        yield n

def test():
    storage = Storage()
    chunk_size = 1000
    num_items = 500000
    # 1000, 500000 -> 13s
    idx = make_root_tree(chunk_size, storage)
    for n in sample_data(num_items):
        add_to_tree(idx, n)

    tree_visit(idx, make_visitor())
    
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

