year = int(input("Please enter a year as a 4 digit: "))
leapyear = ((year % 4 == 0) and (year % 100 != 0)) or (year %400 == 0)
print(leapyear * f"{year} is a leap year")
print((not leapyear) * f"{year} is not a leap year")