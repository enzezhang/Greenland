#!/bin/bash
work_path=/home/zez/JI/optic_velocity/filled_vx
output_path=/home/zez/JI/optic_velocity/angle_filled
cd $work_path
filename=(`ls *vx*.filled.txt`)

count=${#filename[@]}

i=0
while(($i<$count))
	do
	cd $work_path
	echo $i
	vy_name=${filename[i]:0:21}y_v2.filled.txt
	angle_name=${filename[i]:0:20}angle.filled.grd
	echo $vy_name
	xyz2grd -R-219850.000/-132050.000/-2318350.000/-2243450.000 ${filename[i]} -I101 -G${filename[i]:0:33}.grd
	xyz2grd -R-219850.000/-132050.000/-2318350.000/-2243450.000 ${filename[i]} -I101 -G${vy_name:0:33}.grd
	gdal_calc.py -A ${filename[i]} -B $vy_name --outfile=$angle_name --calc="arctan(B/A)"
	mv $angle_name $output_path
	gdal_translate -of GMT $output_path/$angle_name -outsize 5% 5% $output_path/${filename[i]:0:20}angle_desample.filled.grd
	grd2xyz $output_path/${filename[i]:0:20}angle_desample.filled.grd > $output_path/temp.txt
        cat $output_path/temp.txt | gawk '{if ($3!=0.785398185253) print $1,$2,$3/3.14*180,0.3}' > $output_path/${filename[i]:0:20}angle.filled.xyz
	i=$[i+1]
done
