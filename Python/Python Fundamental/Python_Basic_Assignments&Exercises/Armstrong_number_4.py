num = input("please enter a positive number: ").strip()

while not num.isdigit():
    if set(num) & {".", ","}:
        num = input("Please enter an integer number: ").strip()
    elif set(num) & {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"}:
        print("Do not use any entries other than numeric values")
        num = input("please enter a positive number: ").strip()
    elif int(num) < 0:
        num = input("please enter a positive number: ").strip()        

num_len = len(num)
num_list = list(num)
sum = 0

for i in num_list:
    sum += int(i) ** num_len
print("Number you entered:", num)
print("Calculated number:", sum)
if int(num) == sum:
    print ("Number you entered is Armstrong Number")
else:
    print ("Number you entered is not Armstrong Number")

