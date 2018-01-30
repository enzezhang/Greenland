#!/bin/bash
work_path=/home/zez/JI/update_velocity
output_path=/home/zez/JI/xyz_shp
cd $work_path
pwd
filename=(`ls | grep "TSX"`)
count=${#filename[@]}
echo $conut
i=0
while(($i<$count))
	do
	cd $work_path/${filename[i]}

	abs_name=(`ls *.abs.tif`)
	if [ `ls *grd.aux.xml` ];then
	echo "haha"
	else
	echo $abs_name
	echo $i
	gdal_translate -of GMT $abs_name $abs_name.grd
	grd2xyz $abs_name.grd > $output_path/$abs_name.xyz
	fi
	#gdal_translate -of GMT $abs_name $abs_name.grd
	#grd2xyz $abs_name.grd > $output_path/$abs_name.xyz
	#cat $output_path/$abs_name.xyz |gawk '{if($3==2828427008) print $1,$2,0;else print $1,$2,1}' > $output_path/$abs_name.1_0.xyz
	#xyz2grd $output_path/$abs_name.1_0.xyz -R-219850.000/-132050.000/-2318350.000/-2243450.000 -I101 -G$output_path/$abs_name.1_0.grd
	#gdal_translate -of GTiff $output_path/$abs_name.1_0.grd $output_path/$abs_name.1_0.tif 
	#gdal_polygonize.py -8 $output_path/$abs_name.1_0.tif  $output_path/$abs_name.1_0.shp
	i=$[i+1]
	cd ..
done

