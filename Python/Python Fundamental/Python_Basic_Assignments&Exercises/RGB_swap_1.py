rgb = ["G", "B", "B", "G", "R", "R", "G", "R", "B"]
count_r = 0
count_rg = 0
for i in range(len(rgb)):
    if rgb[i] == "R":
        count_r += 1
        count_rg += 1
        del rgb[i]
        rgb.insert(0, "R")
    elif rgb[i] == "G":
        count_rg += 1
        del rgb[i]
        rgb.insert(count_r, "G")
    elif rgb[i] == "B":
        del rgb[i]
        rgb.insert(count_rg, "B")
print(rgb)