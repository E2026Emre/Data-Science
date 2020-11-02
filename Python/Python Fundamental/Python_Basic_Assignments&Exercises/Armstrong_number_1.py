num = input("please enter a positive integer number: ").strip()

while not num.isdigit():
    print(" It is an invalid entry. Don't use non-numeric, float, or negative values!")
    num = input("please enter a positive integer number: ").strip()

num_len = len(num)
num_list = list(num)
sum = 0

for i in num_list:
    sum += int(i) ** num_len

if int(num) == sum:
    print("{} is a Armstrong Number".format(num))
else:
    print("{} is not a Armstrong Number".format(num))