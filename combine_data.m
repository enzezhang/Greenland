clc;
clear;
data1=load('/home/zez/JI/mat/daily_discharge_total_third.mat');
data2=load('/home/zez/JI/mat/daily_discharge_total_third_opt.mat');


for i=1:1
    figure
%     plot(data1.daily_uplift_rate(i).date,data1.daily_uplift_rate(i).data);
%     hold on
% 
%     plot(data2.daily_uplift_rate(i).date,data2.daily_uplift_rate(i).data);
%     

    index=find(data2.daily_discharge_total_third(i).date<data1.daily_discharge_total_third(i).date(1)&data2.daily_discharge_total_third(i).date>2007);


    discharge_total_combine(i).data(1:length(index))=data2.daily_discharge_total_third(i).data(index);
    discharge_total_combine(i).date(1:length(index))=data2.daily_discharge_total_third(i).date(index);
    discharge_total_combine(i).data(length(index)+1:length(index)+length(data1.daily_discharge_total_third(i).date))=data1.daily_discharge_total_third(i).data;
    discharge_total_combine(i).date(length(index)+1:length(index)+length(data1.daily_discharge_total_third(i).date))=data1.daily_discharge_total_third(i).date;
    plot(discharge_total_combine(i).date,discharge_total_combine(i).data)
end



