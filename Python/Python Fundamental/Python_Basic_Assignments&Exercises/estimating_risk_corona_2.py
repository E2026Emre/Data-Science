age = input("Are you a cigarette addict older than 75 years old? (Yes/No) : ").strip().title()
chronic = input("Do you have a severe chronic disease? (Yes/No) : ").strip().title()
immune = input("Is your immune system too weak? (Yes/No) : ").strip().title()
risk = age == "Yes" or chronic == "Yes" or immune == "Yes"
if risk:
    print("You are in risky group")
else:
    print("You are not in risky group")
