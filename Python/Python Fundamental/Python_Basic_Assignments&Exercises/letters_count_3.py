sentence = input("enter a sentence to count the each character separatly : ").strip().lower()
letters = {}
for i in sentence:
    if i in letters.keys():
        letters[i] += 1
    else:
        letters[i] = 1
print(letters)