left_hand = ["q", "a", "z", "w", "s", "x", "e", "d", "c", "r", "f", "v", "t", "g", "b"]
right_hand = ["y", "h", "n", "u", "j", "m", "ı", "k", "ö", "o", "l", "ç", "p", "ş", "ğ", "i", "ü"]
word = input("Please enter a word: ").strip().lower()
wordlist = list(word)
print(wordlist)
n = len(word)
print(n)
x = 0
while x < n:
    left = wordlist[x] in left_hand
    if left == True:
        x = n
    else:
        x += 1
print(left)
x = 0
while x < n:
    right = wordlist[x] in right_hand
    if right == True:
        x = n
    else:
        x += 1
print(right)
comfortable = left and right
print(comfortable)
if comfortable == True:
    print(word, "is a comfortable word")
else:
    print(word, "is not a comfortable word")
