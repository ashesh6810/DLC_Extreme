clc
clear all

summerday=92+6;
year=86;
member=40;

cd /scratch/04435/pedramhx/LESNanalysis/NewAnalysis

load('landNew.mat')
Tland=zeros(length(I),year,summerday,member,'single');
for m=1:member
    m
    filename = sprintf('%s%d.mat','Anomalies',m);
    load(filename,'Ta')
    T=Ta(:,:,32:end,18:124-9);
    for i=1:length(I)
        Tland(i,:,:,m)=squeeze(T(:,I(i),J(i),:));
    end
end
save('LandData2.mat','Tland','-v7.3')
Tland2=Tland(:,:,1:end-6,:);
clear Tland
Tland2=reshape(Tland2,size(Tland2,1),size(Tland2,2)*size(Tland2,3)*size(Tland2,4));

per95=prctile(Tland2,95,2);
per95=squeeze(per95);

save('LandData2.mat','per95','-append')
clear per95

per99=prctile(Tland2,99,2);
per99=squeeze(per99);
save('LandData2.mat','per99','-append')

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

