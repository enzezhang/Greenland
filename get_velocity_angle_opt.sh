#!/bin/bash

# bash get_velocity_angle_opt.sh /home/zez/JI/optic_velocity/filled_abs /home/zez/JI/fluxgate/fluxgate_1st_1.txt 1
work_address=$1
used_file=$2
number=$3
angle_path=/home/zez/JI/optic_velocity/angle_filled
#echo $work_address


cd $work_address	

filename=(`ls *.filled.grd`)


output=/home/zez/JI/optic_velocity/outputfile_third
echo $output

count=${#filename[@]}
echo ${filename[0]}



echo $count

i=0
while (($i<$count))
	do	

	pwd=`pwd`

	filename_pwd=${pwd}\/${filename[i]}
	filename_angle=$angle_path/${filename[i]:0:20}angle.filled.grd
	if [ $i = 0 ];then
		echo $filename_pwd > "$output/datafilename.txt"
		echo $filename_angle> "$output/datafilename2.txt"
	else
		echo $filename_pwd >> "$output/datafilename.txt"
		echo $filename_angle>> "$output/datafilename2.txt"
	fi
	i=$[i+1]
done
#cat "$work_address/test.txt"| gawk '{print $1}'
data_pwd=(`cat "$output/datafilename.txt"| gawk '{print $1}'`)
data_angle=(`cat "$output/datafilename2.txt"| gawk '{print $1}'`)


i=0
#echo $i
while (($i<$count))
	do
		echo ${data_pwd[i]}
		pwd
		cat $used_file | gawk '{print "gdallocationinfo -geoloc "data_pwd" "$2,$3" -valonly "}' data_pwd=${data_pwd[i]} > temp.sh
		cat $used_file | gawk '{print "gdallocationinfo -geoloc "data_pwd" "$2,$3" -valonly "}' data_pwd=${data_angle[i]} > temp2.sh
		echo $i 
		bash temp.sh > velocity.txt
		bash temp2.sh > angle.txt
		paste -d " " $used_file velocity.txt angle.txt > temp.txt
		#echo $i
		echo $number
		cat temp.txt | gawk '{print $2,$3,$5,$6/3.14*180}' >  $output/location_velocity_$3_${filename[i]}.txt


	i=$[i+1]
done



















	
