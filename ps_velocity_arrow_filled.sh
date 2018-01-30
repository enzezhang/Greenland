#!/bin/bash

#bash ps_velocity_arrow_filled.sh
abs_path=/home/zez/JI/velocity_map_filled
angle_path=/home/zez/JI/angle_filled
out_path=~/JI/figure_velocity_arrow_filled

cd $abs_path
abs_file=(`ls *.filled.grd`)

i=0;
count=${#abs_file[@]}
echo $count
while (($i<$count))
do 
	angle_file=${abs_file[i]:0:37}angle.filled.xyz
	figure_name=${abs_file[i]:0:37}abs_angle.filled.ps
	cd ~/JI/figure 
	sh ps_velocity_fluxgate_arrow_gmt5.sh $abs_path/${abs_file[i]} $angle_path/$angle_file $out_path/$figure_name
	i=$[i+1]
done

