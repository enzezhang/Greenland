clc;
clear;
close all;
format long;
path='/home/zez/JI/xyz_shp/';
path3='/home/zez/JI/velocity_map_filled/';
%%%%%%%%%%
%index1 points in polygon with value
%index2 points in polygon without value



file=dir([path '*.tif.xyz']);
for u=1:length(file)
    length(file)
    disp(u)
    file(u).name
    save temp_file file path u path3;
    clear all;
    load temp_file;
    data=load([path file(u).name]);
    
name=[path3 file(u).name(1:47) 'filled.txt' ];
path2='/home/zez/JI/contour_fillgap/';
polygon_file=dir([path2 'contour_fill_gap_second_xy.txt']); 
count_for_polygon=0;
for h=1:length(polygon_file)
    save temp_file2 file path u name path2 path3 polygon_file h data count_for_polygon;
    clear all;
    load temp_file2;
    
polygon_location=load([path2 polygon_file(h).name]);
inxs=inpolygon(data(:,1),data(:,2),polygon_location(:,1),polygon_location(:,2));

m=1;
n=1;
count=0;
for i=1:length(inxs)
    if (inxs(i)>0)
        count=count+1;
       if (data(i,3)==2828427008)
            index2(n)=i;
            n=n+1;
       else
            index1(m)=i;
            m=m+1;
       end
        
    end
end

if(n==(count+1))
    file(u).name
    disp('cant use!!!!!!!!!!!!')
      continue;
elseif(m==(count+1))
    file(u).name
    disp('no need to fill!!!!!!!!!!!')
    continue;
else
    k=length(index2);
    q=length(index1);
end


if (q<(k+q)*0.1)
    disp(file(u).name)
    disp('cant use!!!!!!!!')
    continue;
end



disp(file(u).name)
disp('need to fill')

%%%%%%%%%%%%%%%%%%
%selecting nearby points calculate s(i)  t(i) w(i)
%%%%%%%%%%%%%%%%%%

% count_for_polygon=count_for_polygon+1;
% 
% for i=1:length(index2)
%     %selecting nearby points
%     d=sqrt((data(index2(i),1)-data(index1,1)).^2+(data(index2(i),2)-data(index1,2)).^2);
%     [d_min temp]=sort(d);
%     if (~length(d_min))
%         i
%     end
%     for l=1:15
% %         if (d_min(l)<distance_max)
%             index3(i).index(l)=index1(temp(l));
%             index3(i).data(l)=d_min(l);
% %         else
% %             continue;
% %         end
%     end
%     %calculate s(i)
%     r=index3(i).data(length(index3(i).data));
%     for l=1:length(index3(i).data)
%         if (index3(i).data(l)<=r/3)
%             s(i).data(l)=1/index3(i).data(l);
%         else 
%             s(i).data(l)=27/(4*r)*(index3(i).data(l)/r-1)^2;
%         end
%     end
%     
%     %calculate t(i) w(i)
%     for l=1:length(index3(i).data)
%         DPD=((data(index2(i),1)-data(index3(i).index(l),1))*(data(index2(i),1)-data(index3(i).index,1))+(data(index2(i),2)-data(index3(i).index(l),2))*(data(index2(i),2)-data(index3(i).index,2)))./(index3(i).data(l)*index3(i).data)';
%         t(i).data(l)=s(i).data*(1-cos(DPD))/sum(s(i).data);
%     end
%     w(i).data=s(i).data.^2.*(1+t(i).data);
%     
%     
%     %calculate Ai Bi z(i)
%     for l=1:length(index3(i).data)
%         temp3=(data(index3(i).index(l),1)-data(index3(i).index,1)).^2+(data(index3(i).index(l),2)-data(index3(i).index,2)).^2;
%         temp2=(data(index3(i).index(l),3)-data(index3(i).index,3)).*(data(index3(i).index(l),1)-data(index3(i).index,1));
%         temp4=temp2./temp3;
%         temp4(find(isnan(temp4)))=0;
%         A(i).data(l)=w(i).data*temp4/(sum(w(i).data)-w(i).data(find(isnan(temp2./temp3))));
%         temp5=(data(index3(i).index(l),3)-data(index3(i).index,3)).*(data(index3(i).index(l),2)-data(index3(i).index,2));
%         temp6=temp5./temp3;
%         temp6(find(isnan(temp6)))=0;
%         B(i).data(l)=w(i).data*temp6/(sum(w(i).data)-w(i).data(find(isnan(temp2./temp3))));
%     end
%     v(i)=0.1*(max(data(index3(i).index,3))-min(data(index3(i).index,3)))/max(sqrt(A(i).data.^2+B(i).data.^2));
%     delta_z(i).data=(A(i).data.*(data(index2(i),1)-data(index3(i).index,1))'+B(i).data.*(data(index2(i),2)-data(index3(i).index,2))').*v(i)./(v(i)+index3(i).data);
%     temp7=w(i).data.*(data(index3(i).index,3)'+delta_z(i).data);
%     f(i)=sum(temp7)/sum(w(i).data);
%     data(index2(i),3)=f(i);
% end
% end
% if (count_for_polygon==0)
%     continue;
% else
% dlmwrite(name,data,'delimiter',' ','precision','%f');
% end
end
end
