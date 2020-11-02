while True:
    num = input("please enter a positive integer number: ").strip()
    num_len = len(num)
    sum = 0
    
    if not num.isdigit():
        print(" It is an invalid entry. Don't use non-numeric, float, or negative values!")
    elif int(num) >= 0:
        for i in range(num_len):
            sum += int(num[i]) ** num_len
        if int(num) == sum:
            print("{} is a Armstrong Number".format(num))
            break
        else:
            print("{} is not a Armstrong Number".format(num))
            break