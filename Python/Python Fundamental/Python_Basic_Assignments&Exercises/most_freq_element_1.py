numbers = [1, 3, 7, 4, 3, 0, 3, 6, 3]
a = max(set(numbers), key = numbers.count)
b = numbers.count(a)
print(f"The most frequent number is {a} and it was {b} times repeated.")
