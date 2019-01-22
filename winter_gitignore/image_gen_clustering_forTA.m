clc;
clear all;
close all;
load coastlines

load ('grid.mat');
load(['TanomalyClustering_smallbox_per3K.mat'],'Psifull','PsifullF','PsiA','PsiAF','idx');

nC=4;
samples=21;
s_tr=floor(3*samples/4);
s_ts=floor(samples/4);
lat_north_index=96;
lat_south_index=31;
lon_west_index=157;
lon_east_index=253;
lat1=lat(97:end);
lat11=lat1(31:65);
[qx,qy]=meshgrid(lon(lon_west_index:lon_east_index),lat1(lat_south_index:end));

LABELS=zeros(nC*samples,nC);

for j=1:nC
    count=1;
 for i=1:length(idx)
     
    if (idx(i)==j)
     cluster{j}(:,count)=PsiA(:,i);
     cluster_fullZ{j}(:,count)=Psifull(:,i);
     count=count+1;
    end
 end
end

%%
    false_center=mean(PsiAF,2);
    false_center_full=mean(Psifull,2);
    false_center_meanremoved=reshape(false_center_full,97,66)-mean(reshape(false_center_full,97,66),1);  
%%    



for j=1:nC
    class=squeeze(cluster_fullZ{j});
    Z500_class_centre(:,j)=mean(class,2);
    clear class;
end    
for j=1:nC
    class=squeeze(cluster{j});
    ZA500_class_centre(:,j)=mean(class,2);
    clear class;
end  

for j=1:nC
    class=squeeze(cluster_fullZ{j});
    center=mean(class,2);
    ZZ=reshape(center,97,66);
    ZZZ=ZZ-mean(ZZ,1);
    Z500_class_centre_meanremoved(:,j)=reshape(ZZZ,97*66,1);
    clear class;clear center;
end   

h=figure(1)

for j=1:nC
    Z=reshape(Z500_class_centre(:,j),97,66);
    subplot(2,3,j)
    contourf(qx',qy',Z,10,'LineColor','k','LineWidth',2);axis equal;
%    caxis([5400 5900])     
   % caxis([-120 120])     

    hold on;

    plot(coastlon+360,coastlat,'Linewidth',1,'Color','k');
    xlim([195 315])
    ylim([25 97])
end

figure (1)

Z=reshape(false_center_full,97,66);
subplot(2,3,5)
    contourf(qx',qy',Z,10,'LineColor','k','LineWidth',2);axis equal
 %   caxis([5400 5900])     
    %caxis([-120 120])     

    hold on;

    plot(coastlon+360,coastlat,'Linewidth',1,'Color','k');
    xlim([195 315])
    ylim([25 97])
    
savefig(h,'FullZ500_4clusters.fig')    
h=figure(2)

for j=1:nC
    Z=reshape(Z500_class_centre_meanremoved(:,j),97,66);
    subplot(2,3,j)
    contourf(qx',qy',Z,10,'LineColor','k','LineWidth',2);axis equal
   %caxis([5450 5850])     
  %  caxis([-120 120])     

    hold on;

    plot(coastlon+360,coastlat,'Linewidth',1,'Color','k');
    xlim([195 315])
    ylim([25 97])
end

figure (2)

Z=reshape(false_center_meanremoved,97,66);
subplot(2,3,5)
    contourf(qx',qy',Z,10,'LineColor','k','LineWidth',2);axis equal
    %caxis([5450 5850])     
   % caxis([-120 120])     

    hold on;

    plot(coastlon+360,coastlat,'Linewidth',1,'Color','k');
    xlim([195 315])
    ylim([25 97])    
savefig(h,'Z500meanremoved4clusters.fig')
h=figure(3)

for j=1:nC
    Z=reshape(ZA500_class_centre(:,j),97,66);
    subplot(2,3,j)
    contourf(qx',qy',Z,10,'LineColor','k','LineWidth',2);axis equal
   %caxis([5450 5850])     
    caxis([-120 120])     

    hold on;

    plot(coastlon+360,coastlat,'Linewidth',1,'Color','k');
    xlim([195 315])
    ylim([25 97])
end

figure (3)

Z=reshape(false_center,97,66);
subplot(2,3,5)
    contourf(qx',qy',Z,10,'LineColor','k','LineWidth',2);axis equal
    %caxis([5450 5850])     
   % caxis([-120 120])     

    hold on;

    plot(coastlon+360,coastlat,'Linewidth',1,'Color','k');
    xlim([195 315])
    ylim([25 97])      
    
savefig(h,'Z500anomaly.fig')
    
    












