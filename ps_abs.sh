#!/bin/bash
work_path=/home/zez/JI/velocity_map/Wcoast-69.10N
output_path=/home/zez/JI/figure_velocity_map
cd $work_path
pwd
filename=(`ls | grep "TSX"`)
count=${#filename[@]}
echo $conut
i=0
while(($i<2))
	do
	cd $work_path/${filename[i]}
	abs_name=(`ls *.abs.tif`)
	echo "gdal_translate -of GMT $abs_name $output_path/$abs_name.grd"
	gdal_translate -of GMT $abs_name $work_path/${filename[i]}/$abs_name.grd
	#echo "sh /home/zez/Greenland/figure/ps_velocity_fluxgate_fourth.sh $abs_name.grd $abs_name.ps"
	cd /home/zez/JI/figure
        sh ps_velocity_fluxgate_gmt5.sh $work_path/${filename[i]}/$abs_name.grd $output_path/$abs_name.ps
	i=$[i+1]

done
