#!/bin/bash
work_path=/home/zez/JI/optic_velocity/Wcoast-69.10N
abs_out_path=/home/zez/JI/optic_velocity/abs_xyz
vx_out_path=/home/zez/JI/optic_velocity/vx_xyz
cd $work_path
pwd

filename=(`ls | grep "OPT"`)

count=${#filename[@]}
echo $count
i=0
while(($i<$count))
	do
	cd $work_path/${filename[i]}
	pwd
	vx_name=(`ls *vx_v2.tif`)
	vy_name=(`ls *vy_v2.tif`)
	name_temp=${vx_name:0:19}
	echo $name_temp
	abs_name=$name_temp\_abs.tif
	angle_name=$name_temp\_angle.tif
	commond=`echo gdal_calc.py -A $vx_name -B $vy_name --outfile=$abs_name --calc="pow((pow(A,2)+pow(B,2)),0.5)"`
	echo $commond
	gdal_calc.py -A $vx_name -B $vy_name --outfile=$abs_name --calc="pow((pow(A,2)+pow(B,2)),0.5)"
	gdal_calc.py -A $vx_name -B $vy_name --outfile=$angle_name --calc="arctan(B/A)"
	gdal_translate -of GMT $abs_name $abs_name.grd
	gdal_translate -of GMT -outsize 5% 5% $angle_name $angle_name.grd
	gdal_translate -of GMT $vx_name $vx_name.grd
	gdal_translate -of GMT $vy_name $vy_name.grd
	grd2xyz $vx_name.grd >$vx_out_path/$vx_name.xyz
        grd2xyz $vy_name.grd >$vx_out_path/$vy_name.xyz
	grd2xyz $abs_name.grd >$abs_out_path/$abs_name.xyz

	i=$[i+1]
	cd ../
done
