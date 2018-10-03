%% Checks for non-staionarity in temperature and
 % whether mean is similar to Falses
 
 clear all;
 close all;
 clc;
 
% load ('/Users/ashes/Development/clustering/ExtremeEvents/Z500/grid.mat');
load ('/work/03959/achattop/wrangler/clustering/grid.mat');

ensembles=40;
lat_north_index=96;
lat_south_index=31;
lon_west_index=157;
lon_east_index=253;
lat1=lat(97:end);
lat2=lat1(31:96);
lat11=lat1(31:65);
[qx,qy]=meshgrid(lon(lon_west_index:lon_east_index),lat11);
for m=1:ensembles
  load (['T99daily_NA_M' num2str(m) '.mat']);
    load (['Z99daily_NA_M' num2str(m) '.mat']);

fullT{m}=Ta99NApattern(:,:,:,16:105);
fullZ{m}=Z99NApattern(:,:,:,16:105);
end

count=1;
for m=1:ensembles
    for j=1:25
     for k=1:90
         X1(:,:,count)=fullT{m}(j,:,:,k);
         Z1(:,:,count)=fullZ{m}(j,:,:,k);
      count=count+1;
      
     end
    end
end
grid_mean{1}=mean(X1,3);
Sdev{1}=std(X1,[],3);
grid_mean_Z{1}=mean(Z1,3);
Sdev_Z{1}=std(Z1,[],3);

count=1;
for m=1:ensembles
    for j=60:85
     for k=1:90
         X2(:,:,count)=fullT{m}(j,:,:,k);
         Z2(:,:,count)=fullZ{m}(j,:,:,k);

      count=count+1;
      
     end
    end
end

grid_mean{2}=mean(X2,3);
Sdev{2}=std(X2,[],3);
grid_mean_Z{2}=mean(Z2,3);
Sdev_Z{2}=std(Z2,[],3);

for m=1:2
    Sdev_zonal{m}=mean(Sdev{m},1);
    Sdev_zonal_Z{m}=mean(Sdev_Z{m},1);
    grid_mean_zonal{m}=mean(grid_mean{m},1);
    grid_mean_zonal_Z{m}=mean(grid_mean_Z{m},1);

end




h=figure(1)
subplot(2,2,1)
plot(lat2,Sdev_zonal{1},'b');hold on;
plot(lat2,Sdev_zonal{2},'r');
xlabel('latitude');ylabel('temp std')
title('standard deviation')
legend('1920-1945','1980-2005')


subplot(2,2,2)
plot(lat2,grid_mean_zonal{1},'b');hold on;
plot(lat2,grid_mean_zonal{2},'r');xlabel('latitude');ylabel('temp mean')
title('Mean')
legend('1920-1945','1980-2005')

subplot(2,2,3)
plot(lat2,Sdev_zonal_Z{1},'b');hold on;
plot(lat2,Sdev_zonal_Z{2},'r');
xlabel('latitude');ylabel('Z500 std')
title('standard deviation')
legend('1920-1945','1980-2005')

subplot(2,2,4)
plot(lat2,grid_mean_zonal_Z{1},'b');hold on;
plot(lat2,grid_mean_zonal_Z{2},'r');xlabel('latitude');ylabel('Z500 mean')
title('Mean')
legend('1920-1945','1980-2005')
savefig(h,'non_stat_temperature.fig')
