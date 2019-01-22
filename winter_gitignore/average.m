clear all
close all
clc
% cd /scratch/Erbahim/TREFHT/
lat  = ncread('b.e11.B20TRC5CNBDRD.f09_g16.002.cam.h1.TREFHT.19200101-20051231.nc','lat');
lon  = ncread('b.e11.B20TRC5CNBDRD.f09_g16.002.cam.h1.TREFHT.19200101-20051231.nc','lon');
% date = ncread('b.e11.B20TRC5CNBDRD.f09_g16.002.cam.h1.TREFHT.19200101-20051231.nc','date');
SH_last_index=96;
NH_first_index=97;            %Northern hemisphere first
latSH=lat(1:96);
latNH=lat(97:end);
%summer
SFD=152-15;        %Summer First Day:SFD
SLD=243+15;        %Summer Last Day:SLD
daysummer = 92+30; %all summer days
%winter
WFD=335-15;        %Winter First Day:SFD
WLD=424+15;        %Winter Last Day:SLD
daywinter = 90+30; %all winter days

member = 40;
year = 85;
YP=25;
year_start=1;
%North Pacific lon
NH = 97;
lat_north_index2=96; 
lat_south_index2=31;
lon_west_index2=157;  
lon_east_index2=253; 
lonNA=lon(lon_west_index2:lon_east_index2,1);
latNH=latNH(31:end);

Twinter=zeros(year,97,66,daywinter);
stdd=zeros(member,97,66,daywinter);
Zwinter=Twinter;;

for m=1:member
  load(['Ashesh_USwinter_T' num2str(m) '.mat'],'Twinter_NH')
  load(['Ashesh_USwinter' num2str(m) '.mat'],'Zwinter_NH')
  for y=1:year
        [m y]
        Twinter(y,:,:,:)=(Twinter(y,:,:,:))+(Twinter_NH(y,:,:,:)); %start from May 15, d=18 is June 1st
        Zwinter(y,:,:,:)=(Zwinter(y,:,:,:))+(Zwinter_NH(y,:,:,:));
    end
    for d=1:daywinter
    stdd(m,:,:,d)=std(squeeze(Zwinter(:,:,:,d)),0,1);
    end
end
clear Zwinter_NH Twinter_NH
Twinter=Twinter/member;
Zwinter=Zwinter/member;

Tave=zeros(year,97,66,daywinter);
Zave=zeros(year,97,66,daywinter);
for y=1:year
    for d=16:daywinter-15
        Tave(y,:,:,d)=squeeze(mean(Twinter(y,:,:,d-15:d+15),4));
        Zave(y,:,:,d)=squeeze(mean(Zwinter(y,:,:,d-15:d+15),4));
    end
end
clear Twinter Zwinter
disp('saving average ...')

save('Average_ashesh.mat','Tave','Zave','stdd','-v7.3')
