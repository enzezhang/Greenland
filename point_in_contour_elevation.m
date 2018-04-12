clc;
clear;
elevation_path='/home/zez/JI/elevation/JI_dhdt_2006_2015_2km/';

elevation_path2='/home/zez/JI/elevation/JI_dhdt_2006_2015_2km/in_polygon/'


file=dir([elevation_path '*.llh']);



contour_path='/home/zez/JI/contour_distribute/';
contour=load([contour_path 'contour_distribution_fifth.txt']);


for i=1:length(file)
    data=load([elevation_path file(i).name]);
    
    index=inpolygon(data(:,1),data(:,2),contour(:,2),contour(:,1));
    index_temp=find(index);
    data_new(:,1)=data(index_temp,1);
    data_new(:,2)=data(index_temp,2);
    data_new(:,3)=data(index_temp,3);
    name=[elevation_path2 file(i).name];
    dlmwrite(name,data_new,' ');
end

