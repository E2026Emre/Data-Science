age = input("Are you a cigarette addict older than 75 years old? (True/False) : ")
chronic = input("Do you have a severe chronic disease? (True/False) : ")
immune = input("Is your immune system too weak? (True/False) : ")
risk = age or chronic or immune
print("Your risk assesment :", risk)


