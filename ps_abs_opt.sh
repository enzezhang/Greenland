#!/bin/bash
work_path=/home/zez/JI/optic_velocity/Wcoast-69.10N
abs_out_path=/home/zez/JI/optic_velocity/abs_xyz
vx_out_path=/home/zez/JI/optic_velocity/vx_xyz
out_path=/home/zez/JI/optic_velocity/figure_velocity_arrow
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
	#gdal_calc.py -A $vx_name -B $vy_name --outfile=$abs_name --calc="pow((pow(A,2)+pow(B,2)),0.5)"
	#gdal_calc.py -A $vx_name -B $vy_name --outfile=$angle_name --calc="arctan(B/A)"
	#gdal_translate -of GMT $abs_name $abs_name.grd
	#gdal_translate -of GMT -outsize 5% 5% $angle_name $angle_name.grd
	#gdal_translate -of GMT $vx_name $vx_name.grd
	#gdal_translate -of GMT $vy_name $vy_name.grd


	grd2xyz $angle_name.grd > $angle_name.xyz
	cat $angle_name.xyz | gawk '{if ($3!=1.17549435082e-38) print $1,$2,$3/3.14*180,0.3}' > $angle_name.new.xyz
	#grd2xyz $vx_name.grd >$vx_out_path/$vx_name.xyz
        #grd2xyz $vy_name.grd >$vx_out_path/$vy_name.xyz
	#grd2xyz $abs_name.grd >$abs_out_path/$abs_name.xyz
	cd ~/JI/figure 
	sh ps_velocity_fluxgate_arrow_gmt5.sh $work_path/${filename[i]}/$abs_name.grd $work_path/${filename[i]}/$angle_name.new.xyz $out_path/$abs_name.ps
	i=$[i+1]
	cd ../
done
