clc;
clear;

path='/home/zez/JI/calving_front/geoed_node_two_calving_front/';

path2='/home/zez/JI/calving_front/geoed_node_two_calving_front_seperate/';
contour1=load('~/JI/calving_front/saperate_polygon1.txt');
contour2=load('~/JI/calving_front/saperate_polygon2.txt');

file=dir([path '*.txt']);
for i=1:length(file)
    data=load([path file(i).name]);
    index1=inpolygon(data(:,1),data(:,2),contour1(:,1),contour1(:,2));
    index2=inpolygon(data(:,1),data(:,2),contour2(:,1),contour2(:,2));
    index_temp1=find(index1);
    data1=data(index_temp1,:);
    index_temp2=find(index2);
    data2=data(index_temp2,:);
    name1=[path2 '1_' file(i).name]
    dlmwrite(name1,data1);
    name2=[path2 '2_' file(i).name]
    dlmwrite(name2,data2);
end
