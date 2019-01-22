clc;clear;

member=40;
count=1;
for m=1:member
 load (['T99daily_NA_M' num2str(m) '.mat']);
 load(['Anomalies_spinoff' num2str(2) '.mat']);
 load (['Z99daily_NA_M' num2str(m) '.mat']);
     M{count}=Ta99NApattern(:,:,:,16:105);
     R{count}= Z99NApattern(:,:,:,16:105);
      Q{count}=Ta;
     count=count+1;
end

X=(reshape(M{1},85*97*66*90,1));
%Y=(reshape(R{1},85*97*66*90,1));
%Z=(reshape(Q{1}(:,:,:,:),85*97*66*120,1));
load('LandData.mat','per1');
XX=per1(:);
[fT,xi]=ksdensity(X);
%[fZ,yi]=ksdensity(Y);
%[fA,zi]=ksdensity(Z);
[fB,xxi]=ksdensity(XX);

h=figure(1)
plot(xi,fT,'r'); hold on;
title('full temperature PDF')
savefig(h,'fullfieldT.fig')
close(h)

h=figure(2)
plot(xxi,fB,'b');
title('temperature 1 percentile PDF')
savefig(h,'1perT.fig')
close(h)
