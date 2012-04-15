# list of leaves
# index
# when you add to list of leaves beyond 1000, split, create list of indexes
# when you have more than 1000 indexes, split
# when children get added to, supply split callback and count callback
import random
import os

def make_root_index(max, fn):
    return make_index(max, fn, [])

def make_index(max, fn, elements):
    f = open(fn, 'w')
    for item in elements:
        f.write(str(item) + '\n')
    f.close()
    return {
        'fn': fn,
        'cnt': 0,
        'children': None,
        'max': max,
    }

def add_to_index(index, item):
    add_to_simple_index(index, item)

def add_to_simple_index(index, item):
    max = index['max']
    fn = index['fn']
    f = open(fn, 'a')
    f.write(str(item) + '\n')
    f.close()
    index['cnt'] += 1
    cnt = index['cnt']
    if cnt >= max:
        split_index(index, cnt)

def split_index(index, cnt):
    fn = index['fn']
    elements = [line.strip() for line in open(fn)]
    elements.sort()
    m = (cnt + 1) // 2
    fn_0 = fn + '_0'
    fn_1 = fn + '_1'
    idx_0 = make_index(max, fn_0, elements[0:m])
    idx_1 = make_index(max, fn_1, elements[m:cnt])
    index['children'] = [idx_0, idx_1]
    index['cnt'] = 2
    index['fn'] = None
    os.remove(fn)


def print_index(index):
    if index['children']:
        for idx in index['children']:
            print '--'
            print_index(idx)
    else:
        fn = index['fn']
        for line in open(fn):
            item = line.strip()
            print item

idx = make_root_index(10, '/tmp/foo')
for i in range(10):
    n = random.randint(1, 1000)
    add_to_index(idx, n)
print_index(idx)
    
