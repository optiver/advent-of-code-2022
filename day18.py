l=[eval(f'[{s}]')for s in open('i')]
print(sum(list(map(sum,zip(v,d)))not in l
for v in l
for d in[[0,0,1],[0,0,-1],[0,1,0],[0,-1,0],[1,0,0],[-1,0,0]]))