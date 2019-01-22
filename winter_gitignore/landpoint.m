clc
clear all

summerday=90;
year=85;
member=40;

%cd /scratch/04435/pedramhx/LESNanalysis/NewAnalysis

load('landNewWinter.mat')
load('grid.mat')
Tland=zeros(length(I),year,summerday,member,'single');
for m=1:member
    m
    filename = sprintf('%s%d.mat','Anomalies_spinoff',m);
    load(filename,'Ta')
    T=Ta(:,:,1:end,16:105);
    for i=1:length(I)
         
        Tland(i,:,:,m)=squeeze(T(:,I(i),J(i),:));
             
end
end
save('LandData.mat','Tland','-v7.3')
Tland2=Tland(:,:,1:end-6,:);
clear Tland
Tland2=reshape(Tland2,size(Tland2,1),size(Tland2,2),size(Tland2,3)*size(Tland2,4));

per1=prctile(Tland2,1,3);
per1=squeeze(per1);
save('LandData.mat','per1','-append')

% TAll=[];
% for m=1:member
%     filename = sprintf('%s%d.mat','landgrid',m);
%     load(filename,'Tland')
%     TAll=[TAll,Tland];
% m
% end
%
% size(TAll)
%
% cd /scratch/04435/pedramhx/RB/LESNanalysis
%
% perall=sort(TAll,2);
% per95=prctile(perall,95,2);
% per99=prctile(perall,99,2);
% per95=squeeze(per95);
% per99=squeeze(per99);
% save('perNewsqueeze.mat','per99','per95')

