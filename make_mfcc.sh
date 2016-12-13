data_dir=set_2
config_file=make_mfcc.conf
output_dir=set_2_mfcc
if [ -d $data_dir ]; then
	for entry in $data_dir/*
	do
		echo "creating directory "
		current_dir="$(echo $entry | cut -d/ -f2)"
		echo $current_dir
		mkdir -p $output_dir/$current_dir

		for entry in $data_dir/$current_dir/*
		do
			wav_file_name="$(echo $entry | cut -d/ -f3)"
			wav_file_path=$data_dir/$current_dir/$wav_file_name
			mfc_file_name="$(echo $wav_file_name | cut -d. -f1)"
			mfc_file_name=$mfc_file_name.mfc
			mfc_file_path=$output_dir/$current_dir/$mfc_file_name
			echo "from $wav_file_path to $mfc_file_path"
			HCopy -C $config_file $wav_file_path $mfc_file_path
		done
	done
else
	echo "directory $data_dir not found"
fi


