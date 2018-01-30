
#!bin/bash 
#sh ps_velocity_fluxgate_gmt4.sh
rm gmt.*
#grdname=$1
PS=test_gmt4.ps
gmtset BASEMAP_TYPE inside
gmtset ANNOT_FONT_SIZE_PRIMARY = 10p
gmtset PLOT_DEGREE_FORMAT = ddd:mm:ssF
gmtset ANNOT_OFFSET_PRIMARY = 0.02c 

gmtset OUTPUT_DEGREE_FORMAT = D
CPT=optic.cpt
J=x.00007i/.00007i
D=0.9/10.7/7c/.4c
J_grd=M1.5i
R=-219370/-131102/-2319086/-2243547


gmtset ANNOT_OFFSET_PRIMARY=0.1c

#grd2cpt $grdname > $CPT
psbasemap -J$J -R$R -K -V -P -Ba0  > $PS

grdgradient bed_cuted.grd -A270 -Gbed_gradient -Ne0.6 -V 
grd2cpt bed_cuted.grd -Cgray -Z -E20 -L-1000/500 -Ibed_gradient  > bed.cpt
grdimage bed_cuted.grd -R$R -Cbed.cpt -Ibed_gradient -J$J -K -O >>$PS

grdimage velocity.grd -R$R -Cvelocity.cpt -J$J -K -O >>$PS

gpsbasemap -J$J -R$R -O -V -P -Ba0 >> $PS

