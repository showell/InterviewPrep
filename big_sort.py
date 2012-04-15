# list of leaves
# index
# when you add to list of leaves beyond 1000, split, create list of indexes
# when you have more than 1000 indexes, split
# when children get added to, supply split callback and count callback
import random

def make_index(max, elements = None):
    if not elements:
        elements = []
    return {
        'elements': elements,
        'children': None,
        'max': max,
    }

def add_to_index(index, item):
    index['elements'].append(item)
    if len(index['elements']) >= index['max']:
        index['elements'].sort()

def print_index(index):
    for item in index['elements']:
        print item

idx = make_index(100)
for i in range(100):
    n = random.randint(1, 1000)
    add_to_index(idx, n)
print_index(idx)
    
