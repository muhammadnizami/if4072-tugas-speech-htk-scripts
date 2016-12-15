import os

#listing file
rootdir_wav = "set_2"
array_of_wav = []
array_of_mfcc_complete_path = []
for subdir, dirs, files in os.walk(rootdir_wav):
	dirs.sort()
	files.sort()
	for file in files:
		filepath = file
		mfcc_file_path=subdir[:5]+"_mfcc"+subdir[5:]+'/'+file[:-4]+".mfc"
		mfcc_file_path = mfcc_file_path[:25]+' '+mfcc_file_path[25:]
		array_of_mfcc_complete_path.append(mfcc_file_path)
		filepath = filepath[:9] + " " + filepath[9:17]
		array_of_wav.append(filepath)

array_of_wav.sort(key=lambda s: s.split()[1])
array_of_mfcc_complete_path.sort(key=lambda s: s.split()[1])

#listing sentences
rootdir_tsv = "transcript"
array_of_tsv = []
map_of_transcript = {}
for subdir, dirs, files in os.walk(rootdir_tsv):
	dirs.sort()
	files.sort()
	for file in files:
		if (file != 'sets_final.txt'):
			filepath = file
			with open(rootdir_tsv+"/"+filepath) as tsv:
				separate_by_enter = tsv.read().split('\n')
				for x in separate_by_enter:
					separate_by_tab = x.split('\t')
					if(len(separate_by_tab) >= 2):
						num_str = file[0]+separate_by_tab[0].split('_')[1]
						array_of_tsv.append(separate_by_tab[1])
						map_of_transcript[num_str]=separate_by_tab[1]

#loading pronounciation dictionary
dictfilename = "dict"
dict_set = set([])
with open(dictfilename) as dictfile:
	lines = dictfile.read().split('\n')
	for line in lines:
		separate_by_space = line.split(' ')
		if (len(separate_by_space)>=1):
			dict_set = dict_set | set([separate_by_space[0]])

#writing down words.mlf and train.scp
trainof = open('train.scp', 'w')
of = open('words.mlf', 'w')
of.write("#!MLF!#\n")
for x in range(0, len(array_of_wav)):
	array_of_dict_words = []
	num_str=array_of_wav[x][10:14]
	array_of_words = map_of_transcript[num_str].split(' ')
	for y in array_of_words:
		if (len(y)>0):
			last_y = y[-1:]
			word = ""
			if ((last_y == '.') | (last_y == '?') | (last_y == '!') | (last_y == ',')):
				word=(y[:-1].lower())
			else:
				word=(y.lower())
			if ((word in dict_set) & (len(word)>0)):
				array_of_dict_words.append(word)
	if (len(array_of_dict_words)>0):
		trainof.write(array_of_mfcc_complete_path[x][:25]+array_of_mfcc_complete_path[x][26:30]+'.mfc'+'\n')
		of.write('"*/' + array_of_wav[x][:9] + array_of_wav[x][10:14] + '.lab"' + '\n')
		for word in array_of_dict_words:
			of.write(word)
			of.write('\n')
		if (x<len(array_of_wav)):
			of.write('.\n')
		else:
			of.write('.')

# print(array_of_tsv)
# print(array_of_wav)
