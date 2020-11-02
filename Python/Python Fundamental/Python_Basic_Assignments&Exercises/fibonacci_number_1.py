list_f = [1, 1]
num = 0
i = 2
while num < 55:
    num = list_f[i-1] + list_f[i-2]
    list_f.append(num)
    i += 1
print(list_f)