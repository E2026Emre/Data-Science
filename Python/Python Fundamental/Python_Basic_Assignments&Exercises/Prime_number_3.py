num = int(input("enter a positive number to see prime numbers between 1 and number you entered: "))
prime_num = []
for i in range(1, num+1):
    count = 0
    for j in range(1, i+1):
        if not (i % j): count += 1
    if count == 2:
       prime_num.append(i)
print(f"prime numbers between 1 and {num} : {prime_num}")