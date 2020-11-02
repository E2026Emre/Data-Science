L = ["right 20", "right 30", "left 50", "up 10", "down 20"]
x = y = 0
for i in range(len(L)):
    if L[i].startswith("r") : x = x + int(L[i].split()[1])
    elif L[i].startswith("l") : x = x - int(L[i].split()[1])
    elif L[i].startswith("u") : y = y + int(L[i].split()[1])
    elif L[i].startswith("d") : y = y - int(L[i].split()[1])
print(x, y)