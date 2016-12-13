data_dir=transcript
output_file=wordlist

echo "" >$output_file

list=()

IFS=''
for entry in $data_dir/*-raw.tsv
do
	echo "reading file $entry"
	cat $entry |
	while read line
	do
		sentence="$(echo $line | cut -f2 -s)"
		sentence="${sentence//.}"
		sentence="${sentence//\?}"
		sentence="${sentence//,}"
		sentence="${sentence//\!}"
		sentence="${sentence,,}"
		IFS=' '
		ary=($sentence)
		for key in "${!ary[@]}"
		do
			echo "${ary[$key]}">>$output_file
		done
	done
	echo "sorting"
	sort -u $output_file > $output_file.
	mv $output_file. $output_file
done

