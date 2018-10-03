clear all;clc;
load('Average_ashesh.mat','Tave','Zave')
lat  = ncread('b.e11.B20TRC5CNBDRD.f09_g16.002.cam.h1.TREFHT.19200101-20051231.nc','lat');
lon  = ncread('b.e11.B20TRC5CNBDRD.f09_g16.002.cam.h1.TREFHT.19200101-20051231.nc','lon');

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




for m=1:member
   load(['Ashesh_USwinter_T' num2str(m) '.mat'],'Twinter_NH')
  load(['Ashesh_USwinter' num2str(m) '.mat'],'Zwinter_NH') 
 Ta=zeros(year,97,66,daywinter);
 Za=Ta;
     for y=1:year
        Twinter(y,:,:,:)=squeeze(Twinter_NH(y,:,:,:));
        Zwinter(y,:,:,:)=squeeze(Zwinter_NH(y,:,:,:));
        for d=16:105
            Ta(y,:,:,d)=squeeze(Twinter(y,:,:,d))-squeeze(Tave(y,:,:,d));
            Za(y,:,:,d)=squeeze(Zwinter(y,:,:,d))-squeeze(Zave(y,:,:,d));
        end
    end
 save(['Anomalies_spinoff' num2str(m) '.mat'],'Ta','Za','m','-v7.3')

end
