of = open('output.txt', 'w')
with open('lexicon.txt', 'r') as myfile:
	matriks = []
	for x in myfile:
		arrayofword = x.split(' ',1)
		sentence = arrayofword[0] + " " + "[" + arrayofword[0] + "]" + " " + arrayofword[1]
		matriks.append(sentence)
		of.write("".join(sentence))
	of.close()