import re

def counted_quine():
    "This function has been quined 0 times."
    ds = counted_quine.__doc__
    cnt = int(re.search('(\d+)', ds).group(1)) + 1
    code = '''
def counted_quine():
    "This function has been quined %d times."
    ds = counted_quine.__doc__
    cnt = int(re.search('(\d+)', ds).group(1)) + 1
    code = ''%s%s%s''
    return code %% (cnt, "'", code, "'")'''
    return code % (cnt, "'", code, "'")
        
    
for i in range(1, 3):
    x = counted_quine()
    print i
    print x
    print len(x)
    exec x
