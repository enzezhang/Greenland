clear;
clc;


% 
% load('/home/zez/JI/mat/discharge_total_opt_third.mat')
%  uplift_rate=discharge_totle;
% 
% for i=1:1
%     m=1;
%     for l=1:length(uplift_rate(i).data)-1
%     
%         
%         stime=uplift_rate(i).date1(l);
%         etime=uplift_rate(i).date1(l+1);
%         time_span=round((etime-stime)*365.25);
%         
%         daily_discharge_total_third(i).data(m:m+time_span-1)=uplift_rate(i).data(l)+(uplift_rate(i).data(l+1)-uplift_rate(i).data(l))/time_span*[0:time_span-1];
%         daily_discharge_total_third(i).date(m:m+time_span-1)=uplift_rate(i).date1(l)+[0:time_span-1]/365.25;
%         m=m+time_span;
%         
%         
%     end
%     daily_discharge_total_third(i).data(m)=uplift_rate(i).data(l);
%     daily_discharge_total_third(i).date(m)=uplift_rate(i).date1(l);
%     
% end
% figure 
% plot(daily_discharge_total_third(1).date,-daily_discharge_total_third(1).data)
% hold on 
% plot(uplift_rate(1).date1,-uplift_rate(1).data)
% 
% 
%     
load('/home/zez/JI/mat/dynamic_mass_loss_ahead.mat');      
m=1;
for l=1:length(dynamic_mass_loss_ahead.date)-1
    
        
        stime=dynamic_mass_loss_ahead.date(l);
        etime=dynamic_mass_loss_ahead.date(l+1);
        time_span=round((etime-stime)*365.25);
        
        daily_dynamic_mass_loss_ahead.data(m:m+time_span-1)=dynamic_mass_loss_ahead.data(l)+(dynamic_mass_loss_ahead.data(l+1)-dynamic_mass_loss_ahead.data(l))/time_span*[0:time_span-1];
        daily_dynamic_mass_loss_ahead.date(m:m+time_span-1)=dynamic_mass_loss_ahead.date(l)+[0:time_span-1]/365.25;
        m=m+time_span;
        
        
end

figure
plot(dynamic_mass_loss_ahead.date,dynamic_mass_loss_ahead.data);
hold on;
plot( daily_dynamic_mass_loss_ahead.date, daily_dynamic_mass_loss_ahead.data);

