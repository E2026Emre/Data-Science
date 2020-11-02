n, n1, n2 = 0, 1, 1
list_fibo = [n1, n2]
while n < 55:
    n = n1 + n2
    list_fibo.append(n)
    n1 = n2
    n2 = n
print(list_fibo)