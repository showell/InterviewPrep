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
        'cnt': len(elements),
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
            tree_visit(idx, visitor)
    else:
        fn = tree['fn']
        items = read_ints(fn)
        items.sort()
        print len(items), fn, tree['max']
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
    chunk_size = 500
    num_items = 20000
    # 1000, 1000000 -> 165s, 44s
    # 1000, 500000 -> 78s, 20s
    # 100, 100000 -> 14s
    idx = make_root_tree(chunk_size, storage)
    for n in sample_data(num_items):
        add_to_tree(idx, n)

    tree_visit(idx, make_visitor())
    
class DiskList:
    def __init__(self, fn, elements):
        self.fn = fn
        f = open(self.fn, 'w')
        for item in elements:
            f.write(str(item) + '\n')
        f.close()
        self.cnt = len(elements)
        if self.cnt > 0:
            self.head = elements[0]

    def append(self, item):
        if self.cnt == 0:
            self.head = item
        self.cnt += 1
        f = open(self.fn, 'a')
        f.write(str(item) + '\n')
        f.close()

    def elements(self):
        fn = self.fn
        elements = [int(line.strip()) for line in open(fn)]
        return elements

def test_disk_list():
    dl = DiskList('/tmp/foo', [5])
    for i in range(10):
        dl.append(i)
    print dl.elements()
    print dl.cnt
    print dl.head


if __name__ == '__main__':
    # test()
    test_disk_list()

