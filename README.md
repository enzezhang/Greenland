# Greenland

# workflow:

1.process velocity

related script : fillgap_in_velocity_vx.m fillgap_in_velocity_optic.m fill gap first 

get_shp_fix.sh 	get the velocity boundary shape file for choosing the fluxgate 

arrow_velocity.sh calculate the abs velocity and the angle of the velocity 

pre_process_opt.sh  get this as reference

get_velocity_angle.sh 	get the velocity and angle along the fluxgate 


2. smb and elevation

convert_daily_to_monthly_smb.m this scripy convery daily smb to monthly

extract_monthly_smb_MAR.m  just extract monthly smb

elevation :

interpolate_elevation.m  interpolate elevation in temporal domain to have temporal varying distribution pattern
nterplated_elevation_daily_smb.m calculate elevation-smb to get loading distribution for dynamics


3. calving front data
saperate.m saperate calving front into two parts because of thickness difference
boundary_area.m calculate mass loss (not rate) ahead of the fluxgate
