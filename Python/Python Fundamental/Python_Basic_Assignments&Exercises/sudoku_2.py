sudoku = [
    [0, 0, 0, 0, 6, 4, 0, 0, 0],
    [7, 0, 0, 0, 0, 0, 3, 9, 0],
    [8, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 5, 0, 2, 0, 6, 0],
    [0, 8, 0, 4, 0, 0, 0, 0, 0],
    [3, 5, 0, 6, 0, 0, 0, 7, 0],
    [0, 0, 2, 0, 0, 0, 1, 0, 3],
    [0, 0, 1, 0, 5, 9, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 7, 0, 0]
]
for i in range(len(sudoku)):
    if (i % 3 == 0):
        print("- " * 11)
        print(*sudoku[i][:3], "|", *sudoku[i][3:6], "|", *sudoku[i][6:])
    else:
        print(*sudoku[i][:3], "|", *sudoku[i][3:6], "|", *sudoku[i][6:])
print("- " * 11)