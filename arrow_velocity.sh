#!/bin/bash
#sh arrow_velocity.sh
work_path=/home/zez/JI/velocity_map/Wcoast-69.10N
cd $work_path
pwd

filename=(`ls | grep "TSX"`)

count=${#filename[@]}
echo $conut
i=0
while(($i<$count))
	do
	cd $work_path/${filename[i]}
	pwd
	vx_name=(`ls *vx_v1.2.tif`)
	vy_name=(`ls *vy_v1.2.tif`)
	name_temp=${vx_name:0:42}
	echo $name_temp
	abs_name=$name_temp\.abs.tif
	angle_name=$name_temp\.angle.tif
	commond=`echo gdal_calc.py -A $vx_name -B $vy_name --outfile=$abs_name --calc="pow((pow(A,2)+pow(B,2)),0.5)"`
	echo $commond
	gdal_calc.py -A $vx_name -B $vy_name --outfile=$abs_name --calc="pow((pow(A,2)+pow(B,2)),0.5)"
	
	gdal_calc.py -A $vx_name -B $vy_name --outfile=$angle_name --calc="arctan(B/A)"
	gdal_translate -of GMT $angle_name -outsize 5% 5% $name_temp\.angle.grd
	grd2xyz $name_temp\.angle.grd > $name_temp\.angle.xyz 
	cat $name_temp\.angle.xyz | gawk '{if ($3!=0.785398185253) print $1,$2,$3/3.14*180,0.3}' > $name_temp\.angle.new.xyz 
	cd ~/JI/figure 
	sh ps_velocity_fluxgate_arrow_gmt5.sh $work_path/${filename[i]}/$abs_name.grd $work_path/${filename[i]}/$name_temp\.angle.new.xyz /home/zez/JI/figure_velocity_arrow/$name_temp\.ps
	#echo $abs_name
	i=$[i+1]
	cd ../
done
