clear;
clc;

% path1='/home/zez/JI/smb/Brice_SMB_1km/';
% path2='/home/zez/JI/smb/Brice_SMB_1km/txt/';
path1='/home/zez/JI/smb/MAR_new/';
files=dir([path1 '*.nc']);


contour_path='/home/zez/JI/contour_distribute/';
contour=load([contour_path 'contour_distribution_fifth.txt']);
h=1;

for j=1:length(files)
        file=[path1 files(j).name]
        ncid=netcdf.open(file,'NOWRITE');
        time_id=netcdf.inqVarID(ncid,'time');
        lon_id=netcdf.inqVarID(ncid,'LON');
        lat_id=netcdf.inqVarID(ncid,'LAT');
        x_id=netcdf.inqVarID(ncid,'x');
        y_id=netcdf.inqVarID(ncid,'y');
       % easting_id=netcdf.inqVarID(ncid,'Easting');
        %northing_id=netcdf.inqVarID(ncid,'Northing');    
        smb_id=netcdf.inqVarID(ncid,'SMB');
        time=netcdf.getVar(ncid,time_id,'single');
        lons=netcdf.getVar(ncid,lon_id,'single');
        lats=netcdf.getVar(ncid,lat_id,'single');
        %easting=netcdf.getVar(ncid,easting_id,'single');
        %northing=netcdf.getVar(ncid,northing_id,'single');
        smb=netcdf.getVar(ncid,smb_id,'single')/1000;%??????????????????m
        netcdf.close(ncid);
        [m,n]=size(lons);
        lats1=reshape(lats,m*n,1);
        lons1=reshape(lons,m*n,1);
        area1=1; %%%constant area=1 km^2

        indexs=find(abs(smb1)>10000);
         lats1(indexs)=[];
        lons1(indexs)=[];

        year=files(j).name(end-6:end-3);
        year=str2num(year);
        smb1=reshape(smb(:,:,:),m*n,size(smb,3));
        smb1(indexs,:)=[];        
        smb_monthly.data(:,h:h+11)=smb1;
        h=h+12
  
        
end

index1=inpolygon(lons1,lats1,contour(:,1),contour(:,2));
index1_temp=find(index1);

smb_monthly.time=[2000:1/12:2016];
smb_monthly.time=smb_monthly.time(1:end-1);
smb_monthly.data=smb_monthly.data(index1_temp,:);
smb_monthly.location=[lats1(index1_temp),lons1(index1_temp)];


        