clear;
clc;
path='/home/zez/JI/calving_front/geoed_node_two_calving_front_seperate/';
path2='/home/zez/JI/calving_front/geoed_node_fluxgate_seperate/'
load('~/JI/mat/smb_ahead_flux1.mat');
load('~/JI/mat/smb_ahead_flux2.mat');
files1=dir([path '1*.txt']);
files2=dir([path '2*.txt']);
path3='~/JI/calving_front/figure/'

%use reference date is 2009/02/05
year_0=2009;
month_0=02;
day_0=05;
date_0=year_0+(datenum(year_0,month_0,day_0)-datenum(year_0,1,1))/365.25;
index_0=find(abs(smb_ahead_flux1.date-date_0)<0.001)
contour_0_1=load([path2 '1_20090205.txt']);
contour_0_2=load([path2 '2_20090205.txt']);
index_spacial_temp1=inpolygon(smb_ahead_flux1.location(:,2),smb_ahead_flux1.location(:,1),contour_0_1(:,1),contour_0_1(:,2));
index_special1=find(index_spacial_temp1);
index_spacial_temp2=inpolygon(smb_ahead_flux2.location(:,2),smb_ahead_flux2.location(:,1),contour_0_2(:,1),contour_0_2(:,2));
index_special2=find(index_spacial_temp2);

mass_loss_smb0_1=sum(smb_ahead_flux1.data(index_0,index_special1))*1000000;
size(smb_ahead_flux1.data(index_0,index_special1))
mass_loss_smb0_2=sum(smb_ahead_flux2.data(index_0,index_special2))*1000000;
size(smb_ahead_flux2.data(index_0,index_special2))



for i=1:length(files1)
   % figure
    files1(i).name
    data1=load([path files1(i).name]);
    [x1,y1]=polarstereo_fwd(data1(:,2),data1(:,1),6378388.0,0.0819919,70,-45);
    data2=load([path files2(i).name]);
    [x2,y2]=polarstereo_fwd(data2(:,2),data2(:,1),6378388.0,0.0819919,70,-45);
    
    year=str2num(files1(i).name(3:6));
    if (year==2016)
        break;
    end
    month=str2num(files1(i).name(7:8));
    day=str2num(files1(i).name(9:10));
    date(i)=year+(datenum(year,month,day)-datenum(year,1,1))/365.25;
    index(i)=find(abs(smb_ahead_flux1.date-date(i))<0.00147);
    contour1=load([path2 files1(i).name]);
    index_spacial_temp1=inpolygon(smb_ahead_flux1.location(:,2),smb_ahead_flux1.location(:,1),contour1(:,1),contour1(:,2));
    index_special1=find(index_spacial_temp1);
    contour2=load([path2 files2(i).name]);
    index_spacial_temp2=inpolygon(smb_ahead_flux2.location(:,2),smb_ahead_flux2.location(:,1),contour2(:,1),contour2(:,2));
    index_special2=find(index_spacial_temp2);
    
    
  %  x=data(:,1);
   % y=data(:,2);
    k=boundary(data1(:,1),data1(:,2),1);
%    figure
%    plot(x1,y1,'*b');
%   hold on
%    plot(x1,y1,'r');
%   hold off
   %saveas(gcf,[path2 'two_calving_' num2str(year) '_' num2str(month) '.tif'])
    mass_loss_smb1(i)=sum(smb_ahead_flux1.data(index(i),index_special1))*1000000-mass_loss_smb0_1;
    size(smb_ahead_flux1.data(index(i),index_special1))
    mass_loss_smb2(i)=sum(smb_ahead_flux2.data(index(i),index_special2))*1000000-mass_loss_smb0_2;
    size(smb_ahead_flux2.data(index(i),index_special2))
    
    A1(i)=polyarea(x1,y1);
    A2(i)=polyarea(x2,y2);
    mass_loss_area1(i)=A1(i)*729*917;
    mass_loss_area2(i)=A2(i)*187*917;
end


figure

plot(date,mass_loss_area1,date,mass_loss_area2,date,-mass_loss_smb1,date,-mass_loss_smb2);

legend('A1','A2','smb1','smb2')
figure
plot(date,mass_loss_smb1,date,mass_loss_smb2);
legend('smb1','smb2')

mass_loss_area=mass_loss_area1+mass_loss_area2+mass_loss_smb1+mass_loss_smb2;
figure
plot(date,mass_loss_area)

dynamic_mass_loss_ahead.data=mass_loss_area;
dynamic_mass_loss_ahead.date=date;

area_change.data=A1+A2;
area_change.date=date;

%figure 

%plot(date,A,'*-');
% clc;
% clear;
% format long
% data=load('~/JI/calving_front/geoed_node/20160906.txt');
% 
% [data2(:,2),data2(:,1)]=polarstereo_inv(data(:,1),data(:,2),6378388.0,0.0819919,70,-45);
% 
% dlmwrite('~/JI/calving_front/geoed_node/20160906.txt',data2,' ');
