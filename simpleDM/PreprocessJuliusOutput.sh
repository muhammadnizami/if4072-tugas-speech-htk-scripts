i=2
echo "" > juliusOutputTmp
cat juliusOutput | 
while read line
do
	echo $line >> juliusOutputTmp
	if [ "$line" == "------" ]; then
		filepath=$(sed "${i}q;d" wavlst)
		filename=$(basename "$filepath")
		echo "input speechfile: $filename" >> juliusOutputTmp
		i=$((i+1))
	fi
done
cat juliusOutputTmp
cat juliusOutputTmp > juliusOutput
rm juliusOutputTmp