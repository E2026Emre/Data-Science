num = int(input("enter a positive number to check if it is a prime number: "))
if num > 1:
    for i in range(2, int((num+1)/2)): # daha az işlem için bu şekilde yapılmıştır
        if num % i == 0:
             print(num, "is not a prime number")
             print(i, "times", num//i, "is", num)
             break
    else:
        print(num, "is a prime number")
else:
    print(num, "is not a prime number")

    