clear all;
close all;
clc;

ensembles=40;
%load ('/Users/ashes/Development/clustering/ExtremeEvents/Z500/grid.mat');
load ('grid.mat');
%load ('/work/03959/achattop/wrangler/clustering/grid.mat');

rhs=10;
lhs=5;
manual=1;
cnt_ens=1;
lat_north_index=96;
lat_south_index=31;
lon_west_index=157;
lon_east_index=253;
lat1=lat(97:end);
lat11=lat1(31:65);
[qx,qy]=meshgrid(lon(lon_west_index:lon_east_index),lat11);
%[qx,qy]=meshgrid(1:97,1:66);
count=1;
for m=1:ensembles
 load (['T99daily_NA_M' num2str(m) '.mat']);
 load (['Z99daily_NA_M' num2str(m) '.mat']);

  M{count}=Ta99NApattern(:,:,:,16:105);
%  Zave=squeeze(mean(Z99NApattern(:,:,:,16:105),2));
%    M{m}=Z99NApattern(:,:,:,16:105);
%     for i=1:97
%        anomalies(:,i,:,:)=squeeze(Z99NApattern(:,i,:,16:105))-Zave; 
%     end
     R{count}=Za99NApattern(:,:,:,16:105);
%     R{count}=anomalies(:,:,:,:);
  fullZ{count}=Z99NApattern(:,:,:,16:105);
%   Tanomaly{count}=Ta99NApattern(:,:,:,16:105);
  count=count+1;
end


for j=1:ensembles
    LOGIC{j}=zeros(85*90,1);
end

 LOGIC1=zeros(90,1);
 LOGIC2 =[];


load ('Heatwave99.mat')

for m=1:ensembles
    for i=1:85
     LOGIC1=zeros(90,1);
    x=find((Heatwave5day99(16:105,i,m)==true));
    for k=1:length(x)
       if(LOGIC1(x(k))==2)

        else
      LOGIC1(x(k))=1;
      if(x(k)-lhs>0)
      LOGIC1(x(k)-1:-1:x(k)-lhs)=2;
      elseif(x(k)~=1)
      LOGIC1(x(k)-1:-1:1)=2;

      end
      if (x(k)+rhs<90)
      LOGIC1(x(k)+1:x(k)+rhs)=2;
      else
      LOGIC1(x(k)+1:90)=2;

      end
       end
    end
      LOGIC2=[LOGIC2;LOGIC1];
    end
    LOGIC{m}=LOGIC2;
 LOGIC2 =[];

end

count=1;
countF=1;
for m=1:ensembles
   for i=1:85
     for j=1:90
       if(LOGIC{m}((i-1)*90+j)==1)
%            h=figure(1)
%            load coastlines
%            contourf(qx',qy',squeeze(fullZ{m}(i,:,:,j)))
%           % caxis([-20 27])
%            
%             hold on
%      plot(coastlon+360,coastlat,'Linewidth',1,'Color','k');
%      axis equal
%      xlim([195 315])
%      ylim([25 90])
%            pause;
%            close(h);
         X(:,count)=reshape(M{m}(i,:,1:35,j),97*35,1);
         PsiA(:,count)=reshape(R{m}(i,:,:,j),97*66,1);
         Psifull(:,count)=reshape(fullZ{m}(i,:,:,j),97*66,1);
         count=count+1;
       
       elseif(LOGIC{m}((i-1)*90+j)==0)
%            load coastlines
%            contourf(qx',qy',squeeze(fullZ{m}(i,:,:,j)))
%           % caxis([-20 27])
%            
%             hold on
%      plot(coastlon+360,coastlat,'Linewidth',1,'Color','k');
%      axis equal
%      xlim([195 315])
%      ylim([25 90])
%            pause;
%            close(h);
          Xfalse(:,countF)=reshape(M{m}(i,:,1:35,j),97*35,1);
          PsiAF(:,countF)=reshape(R{m}(i,:,:,j),97*66,1);
          PsifullF(:,countF)=reshape(fullZ{m}(i,:,:,j),97*66,1);
          countF=countF+1;
       end
     end
   end
end


 [EOFs,PCval]=EOFanalysis(X);
% 
% 
% % figure
% % plot(silval(:,1), silval(:,2),'r*-.')   %plots avg silhouette value plot
% 
%if we want to manually select clusters from plot
if manual == 1
  
   nC=4;
   nEOF = 50;

%if we want to just select highest avg silhouette value between 4-20 clusters
elseif manual == 0
    EOFmax=30;
    Sval = zeros(4,EOFmax);
    for nEOF=5:EOFmax
        nEOF
        Xr = squeeze(EOFs(:,end-nEOF+1:end))'*X;
        Xtr=Xr';

        %calculate mean silhouette values for certain numbers of clusters
        silval = [];
        for r = 2:4
            [idx,C] = kmeans(Xtr,r,'replicates',100);
            S = silhouette(Xtr,idx);        %calculates silhouette values
            silval = [silval; r mean(S)];   %puts average silhouette value in table
            Sval(r,nEOF) = mean(S);
        end
    end
    h=figure(1)
    pcolor(1:4,1:EOFmax,Sval');colorbar
    im=frame2im(getframe(gca));
    imwrite(im,['silhouttevalues' num2str(ensembles) '.png'])
    disp('Chosen based on the silhouette values')
    [nC,nEOF] = find(max(max(Sval)) == Sval)
    close(h);
else
    disp('manual must be 0 or 1, no or yes')
end

Xr = squeeze(EOFs(:,end-nEOF+1:end))'*X;
Xtr=Xr';
sum(PCval(end-nEOF+1:end))*100.0/sum(PCval)

%kmeans replicated 1000 times (like Souri)
[idx, Cr] = kmeans(Xtr,nC,'replicates',1000);

Count(nC,1)=0;
for n=1:nC
    for d=1:length(idx)
        if(idx(d)==n)
            Count(n)=Count(n)+1;
        end
    end
end
[sum(Count) length(idx)]
h=figure(1)
silhouette(Xtr,idx);
%saveas(h,['silhouttevalues' num2str(ensembles) '.png'])
%close(h);
C = squeeze(EOFs(:,end-nEOF+1:end))*Cr';
C = C';
%plot code is generalized to stepping in data for lat/long
h=figure(2)
load coastlines
for n=1:nC
    subplot(ceil(nC/3),3,n)                 %makes subplots big enough
    Z=(reshape(C(n,1:size(C,2)),97,35));
    contourf(qx',qy',Z,10);
    %caxis([-max(max(abs(Z))) max(max(abs(Z)))])
    caxis([-20 20])
    hold on
    plot(coastlon+360,coastlat,'Linewidth',1,'Color','k');
    axis equal
    xlim([195 315])
    ylim([25 90])

end

T_false_cluster=mean(Xfalse,2);

figure(2)
subplot(2,3,5)
Z=reshape(T_false_cluster,97,35);
contourf(qx',qy',Z,10);hold on
caxis([-20 20])

%caxis([-max(max(abs(Z))) max(max(abs(Z)))]);
 plot(coastlon+360,coastlat,'Linewidth',1,'Color','k');
    axis equal
    xlim([195 315])
    ylim([25 90])



%% Add the T FALSE cluster


 savefig(h,['Cold_Wave_Tanomaly' num2str(nC) 'ensemblesize' num2str(ensembles) '.fig'])
close(h)
 hold off
 save('TanomalyClustering_smallbox_per3K.mat','X','Count','PsiA','Psifull','PsiAF','PsifullF','idx','-v7.3');
% 


