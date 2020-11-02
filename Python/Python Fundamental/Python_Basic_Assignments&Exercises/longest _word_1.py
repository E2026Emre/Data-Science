sentence = input("please enter a sentence: ")
word_list = sentence.split(" ")
i = 0
longest = 0
while i <= (len(word_list)-1):
    if len(word_list[i]) > longest:
        longest = len(word_list[i])
        longest_word = word_list[i]
    i += 1    
print(sentence, longest_word, longest, sep = "\n")
        
