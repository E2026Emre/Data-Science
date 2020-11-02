xx = [1, 2, 3]
result = [[]]
for j in xx:
    my_perms = []
    for p in result:
        for i in range(len(p)+1):
            my_perms.append(p[:i] + [j] + p[i:])
            result = my_perms
print(result)