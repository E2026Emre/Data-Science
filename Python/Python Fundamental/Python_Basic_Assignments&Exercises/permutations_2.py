lst = [1,2,3,4]
p=[[x for x in range(0)]]
for i in range(len(lst)):
    p = [[a] + b for a in lst for b in p if (a not in b)]
print(p)