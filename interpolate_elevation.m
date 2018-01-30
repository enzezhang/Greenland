clc;
clear;


elevation_path='/home/zez/JI/elevation/JI_dhdt_2006_2015_2km/in_polygon/';


file=dir([elevation_path '*.llh']);


for i=1:length(file)+1
    
    if(i==1)
        temp=load([elevation_path file(i).name]);
        accu_elevation.location=temp(:,1:2);
        accu_elevation.data(i,:)=zeros(length(temp(:,3)),1);
    else
        temp=load([elevation_path file(i-1).name]);
        accu_elevation.data(i,:)=accu_elevation.data(i-1,:)+temp(:,3)';
    end
        accu_elevation.year(i)=2005+4/12+i;
    
end


x=[2006+4/12:1/12:2016+4/12];

y1=interp1(accu_elevation.year,accu_elevation.data(:,:),x,'spline');

interp_elevation_change_rate.data=(y1(2:end,:)-y1(1:end-1,:))*12;

interp_elevation_change_rate.date=x(1:end-1);

interp_elevation_change_rate.location=temp(:,1:2);
