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
lat_north_index2=96; 
lat_south_index2=31;
lon_west_index2=157;  
lon_east_index2=253; 
lonNA=lon(lon_west_index2:lon_east_index2,1);
latNH=latNH(31:end);

% Zsummer_All_Member_NH=zeros(YP,length(lon),length(latNH),daywinter,'single');
Twinter_NH=zeros(year,length(lonNA),length(latNH),daywinter,'single');

%stdd_Summer_NA=zeros(member,length(lonNA),length(latNH),daywinter,'single');

for m=1:member
    if m==1
    filename = sprintf('%s%.3d%s.nc','b.e11.B20TRC5CNBDRD.f09_g16.',m,'.cam.h1.TREFHT.18500101-20051231');
    Z1  = ncread(filename,'TREFHT');
    Z1=Z1(:,:,(1920-1850)*365:end);
    elseif m<=35 
    filename = sprintf('%s%.3d%s.nc','b.e11.B20TRC5CNBDRD.f09_g16.',m,'.cam.h1.TREFHT.19200101-20051231');    
    Z1  = ncread(filename,'TREFHT');
    else
    filename = sprintf('%s%.3d%s.nc','b.e11.B20TRC5CNBDRD.f09_g16.',m+65,'.cam.h1.TREFHT.19200101-20051231');    
    Z1  = ncread(filename,'TREFHT');
    end
    filename = sprintf('%s%d.mat','Ashesh_USwinter_T',m);
    for y=year_start:year
        [m y]
%         Zwinter_All_Member_NH(y,:,:,:)=squeeze(Zwinter_All_Member_NH(y,:,:,:))+squeeze(Z1(:,NH_first_index:end,WFD+365*(year-YP+y-1):WLD+365*(year-YP+y-1)));
        Twinter_NH(y,:,:,:)=squeeze(Z1(lon_west_index2:lon_east_index2,NH_first_index+30:end,WFD+365*(y-1):WLD+365*(y-1)));

    end
    save(filename,'Twinter_NH')
end
