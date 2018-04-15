clear;
clc;



load('/home/zez/JI/mat/discharge_total_third.mat')


 uplift_rate=discharge_totle;

for i=1:1
    m=1;
    for l=1:length(uplift_rate(i).data)
    
        
        stime=uplift_rate(i).date1(l);
        etime=uplift_rate(i).date2(l);
        time_span=round((etime-stime)*365.25);
        
        daily_discharge_total_third(i).data(m:m+time_span-1)=uplift_rate(i).data(l);
        daily_discharge_total_third(i).date(m:m+time_span-1)=uplift_rate(i).date1(l)+[0:time_span-1]/365.25;
        m=m+time_span;
        
        
    end
    daily_discharge_total_third(i).data(m)=uplift_rate(i).data(l);
    daily_discharge_total_third(i).date(m)=uplift_rate(i).date2(l);
    figure 
    plot(daily_discharge_total_third(i).date,-daily_discharge_total_third(i).data)
end


    
        