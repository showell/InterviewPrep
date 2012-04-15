# list of leaves
# index
# when you add to list of leaves beyond 1000, split, create list of indexes
# when you have more than 1000 indexes, split
# when children get added to, supply split callback and count callback
import random

def make_root_index(max):
    return make_index(max, [])

def make_index(max, elements):
    return {
        'elements': elements,
        'children': None,
        'max': max,
    }

def add_to_index(index, item):
    add_to_simple_index(index, item)

def add_to_simple_index(index, item):
    max = index['max']
    elements = index['elements']
    elements.append(item)
    cnt = len(elements)
    if cnt >= max:
        split_index(index, elements, cnt)

def split_index(index, elements, cnt):
    elements.sort()
    m = (cnt + 1) // 2
    idx1 = make_index(max, elements[0:m])
    idx2 = make_index(max, elements[m:cnt])
    index['children'] = [idx1, idx2]
    index['elements'] = None


def print_index(index):
    if index['children']:
        for idx in index['children']:
            print '--'
            print_index(idx)
    else:
        for item in index['elements']:
            print item

idx = make_root_index(10)
for i in range(10):
    n = random.randint(1, 1000)
    add_to_index(idx, n)
print_index(idx)
    
