import random
import os
import glob

def make_root_tree(max, fn):
    return make_tree(max, fn, [])

def make_tree(max, fn, elements):
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
    fn_0 = fn + '_0'
    fn_1 = fn + '_1'
    idx_0 = make_tree(max, fn_0, elements[0:m])
    idx_1 = make_tree(max, fn_1, elements[m:cnt])
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
        print fn
        for item in sorted(read_ints(fn)):
            visitor(item)

chunk_size = 100
num_items = 50000
for fn in glob.glob('/tmp/foo*'):
    os.remove(fn)
idx = make_root_tree(chunk_size, '/tmp/foo')
for i in range(num_items):
    n = random.randint(1, 100000)
    add_to_tree(idx, n)
def visit(item):
    print item
tree_visit(idx, visit)
    
