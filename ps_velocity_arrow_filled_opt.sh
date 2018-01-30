#!/bin/bash

#	bash ps_velocity_arrow_filled_opt.sh
abs_path=/home/zez/JI/optic_velocity/filled_abs
angle_path=/home/zez/JI/optic_velocity/angle_filled
out_path=/home/zez/JI/optic_velocity/figure_velocity_arrow_filled

cd $abs_path
abs_file=(`ls *.filled.grd`)

i=0;
count=${#abs_file[@]}
echo $count
while (($i<$count))
do 
	angle_file=${abs_file[i]:0:20}angle.filled.xyz
	figure_name=${abs_file[i]:0:20}abs_angle.filled.ps
	cd ~/JI/figure 
	sh ps_velocity_fluxgate_arrow_gmt5.sh $abs_path/${abs_file[i]} $angle_path/$angle_file $out_path/$figure_name
	i=$[i+1]
done

