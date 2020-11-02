num = int(input("enter a positive number to check if it is a prime number: "))
count = 0
for i in range(1, num+1):
    if not (num % i): count += 1
if (num == 0) or (num == 1) or (count >= 3): print(num, "is not a prime number")
else: print(num, "is a prime number") 
