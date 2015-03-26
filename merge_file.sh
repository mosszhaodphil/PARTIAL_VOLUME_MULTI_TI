#!/bin/sh

echo "Merging files..."

output_file=asldata_gm_k5

file_list=""

for (( i = 0; i < 78; i++ )); do

	zero_pad_value=$(printf "%03d" $i)

	# echo $zero_pad_value

	new_file=asldata_ti_"$zero_pad_value"_gm_k5

	echo $new_file

	file_list=$file_list" $new_file"

done

fslmerge -t $output_file $file_list

echo "Finished!"