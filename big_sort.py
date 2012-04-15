# list of leaves
# tree
# when you add to list of leaves beyond 1000, split, create list of treees
# when you have more than 1000 treees, split
# when children get added to, supply split callback and count callback
import random
import os

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

def split_tree(tree, max, cnt):
    fn = tree['fn']
    elements = [int(line.strip()) for line in open(fn)]
    elements.sort()
    m = (cnt + 1) // 2
    fn_0 = fn + '_0'
    fn_1 = fn + '_1'
    idx_0 = make_tree(max, fn_0, elements[0:m])
    idx_1 = make_tree(max, fn_1, elements[m:cnt])
    tree['children'] = [idx_0, idx_1]
    tree['cnt'] = 2
    tree['fn'] = None
    os.remove(fn)


def print_tree(tree):
    if tree['children']:
        for idx in tree['children']:
            print '--'
            print_tree(idx)
    else:
        fn = tree['fn']
        for line in open(fn):
            item = line.strip()
            print item

idx = make_root_tree(10, '/tmp/foo')
for i in range(35):
    n = random.randint(1, 1000)
    add_to_tree(idx, n)
print_tree(idx)
    
