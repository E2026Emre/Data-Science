sentence = input("enter a sentence to count the each character separatly : ").strip().lower()
letters = {}
for i in sentence:
    count = 0
    for j in sentence:
        if i == j:
            count += 1
    letters[i] = count
print(letters)