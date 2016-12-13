data_dir=set_2_mfcc
output_file=train.scp
if [ -d $data_dir ]; then
	for entry in $data_dir/*
	do
		current_dir="$(echo $entry | cut -d/ -f2)"
		echo "scanning directory $data_dir/$current_dir"

		for entry in $data_dir/$current_dir/*
		do
			echo $entry>>train.scp
		done
	done
else
	echo "directory $data_dir not found"
fi


