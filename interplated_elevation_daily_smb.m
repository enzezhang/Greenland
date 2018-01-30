clc;
clear;
path='~/JI/mat/';
path_out='/home/zez/JI/elevation_smb/monthly_fifth/';


load([path 'smb_monthly_inpolygon_MAR_new.mat'])

load([path 'interp_elevation_change_rate_inpolygon.mat'])


contour_path='/home/zez/JI/contour_distribute/';
contour=load([contour_path 'contour_distribution_fifth.txt']);

% 
% index=inpolygon(interp_elevation_change_rate.location(:,1),interp_elevation_change_rate.location(:,2),contour(:,2),contour(:,1));
% 
% index2=find(index);
% 
% interp_elevation_change_rate.location=interp_elevation_change_rate.location(index2,:);
% 
% interp_elevation_change_rate.data=interp_elevation_change_rate.data(:,index2);
% 
% index3=inpolygon(smb_monthly.location(:,1),smb_monthly.location(:,2),contour(:,2),contour(:,1));
% 
% index4=find(index3);
% 
% smb_monthly.location=smb_monthly.location(index4,:);
% 
% smb_monthly.data=smb_monthly.data(index4,:);

x_elevation=interp_elevation_change_rate.location(:,2);
y_elevation=interp_elevation_change_rate.location(:,1);


x_smb=smb_monthly.location(:,2);
y_smb=smb_monthly.location(:,1);

[X_elevation,X_smb]=meshgrid(x_elevation,x_smb);
[Y_elevation,Y_smb]=meshgrid(y_elevation,y_smb);


DIS=(X_elevation-X_smb).^2+(Y_elevation-Y_smb).^2;

[temp,index_dis]=min(DIS);



for i=1:length(interp_elevation_change_rate.date)
    i

    time=interp_elevation_change_rate.date(i);
    [temp index_time]=min(abs((time-smb_monthly.time)))
    year=num2str(fix(time));
    month=num2str(rem(time,1)*12+1);
    
    elevation_smb_monthly.data(:,i)=interp_elevation_change_rate.data(i,:)-smb_monthly.data(index_dis,index_time)'/0.913;
    elevation_smb_monthly.date(i)=time;
    data(:,1)=x_elevation;
    data(:,2)=y_elevation;
    data(:,3)=elevation_smb_monthly.data(:,i);
    name=[path_out year '_' month '.txt'];
    dlmwrite(name,data,' ');
end



    
    
    
    
    
    