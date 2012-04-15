import random
import os
import glob

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

def make_tree(max, storage, elements):
    fn = storage.get_fn()
    f = open(fn, 'w')
    for item in elements:
        f.write(str(item) + '\n')
    f.close()
    if elements:
        head = elements[0]
    else:
        head = None
    return {
        'fn': fn,
        'storage': storage,
        'cnt': 0,
        'children': None,
        'max': max,
        'head': head
    }

def add_to_tree(tree, item):
    children = tree['children']
    if children:
        add_to_parent_tree(tree, children, item)
    else:
        add_to_simple_tree(tree, item)

def get_position(children, item):
    last = len(children) - 1
    for i in range(last):
        head = children[i+1]['head']
        if item < head:
            return i
    return last

def add_to_parent_tree(tree, children, item):
    pos = get_position(children, item)
    add_to_tree(children[pos], item)

def add_to_simple_tree(tree, item):
    max = tree['max']
    fn = tree['fn']
    f = open(fn, 'a')
    f.write(str(item) + '\n')
    f.close()
    tree['cnt'] += 1
    cnt = tree['cnt']
    if cnt >= max:
        split_tree(tree, max, cnt)

def read_ints(fn):
    elements = [int(line.strip()) for line in open(fn)]
    return elements

def split_tree(tree, max, cnt):
    fn = tree['fn']
    elements = sorted(read_ints(fn))
    m = (cnt + 1) // 2
    storage = tree['storage']
    idx_0 = make_tree(max, storage, elements[0:m])
    idx_1 = make_tree(max, storage, elements[m:cnt])
    tree['children'] = [idx_0, idx_1]
    tree['cnt'] = 2
    tree['fn'] = None
    os.remove(fn)


def tree_visit(tree, visitor):
    if tree['children']:
        for idx in tree['children']:
            print '--'
            tree_visit(idx, visitor)
    else:
        fn = tree['fn']
        items = read_ints(fn)
        items.sort()
        print fn, len(items)
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

def sample_data():
    for i in range(num_items):
        n = random.randint(1, 100000)
        yield n

storage = Storage()
chunk_size = 100
num_items = 10000
# 1000, 1000000 -> 165s, 44s
# 1000, 500000 -> 78s, 20s
# 100, 100000 -> 14s
idx = make_root_tree(chunk_size, storage)
for n in sample_data():
    add_to_tree(idx, n)

tree_visit(idx, make_visitor())
    
