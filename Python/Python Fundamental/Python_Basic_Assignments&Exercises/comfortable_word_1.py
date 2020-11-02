left_hand = {"q", "a", "z", "w", "s", "x", "e", "d", "c", "r", "f", "v", "t", "g", "b"}
right_hand = {"y", "h", "n", "u", "j", "m", "ı", "k", "ö", "o", "l", "ç", "p", "ş", "ğ", "i", "ü"}
word = input("Please enter a word: ").strip().lower()
wordset = set(word)
output = (wordset & right_hand) != set() and (wordset & left_hand) != set()
print(output)