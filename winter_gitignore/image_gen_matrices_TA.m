clc;
clear all;
close all;
load coastlines

load ('/work/03959/achattop/wrangler/clustering/grid.mat');

load('TanomalyClustering_smallbox_per3K.mat','PsiA','PsiAF','idx');





nC=4;
samples=1000;
s_tr=floor(3*samples/4);
s_ts=floor(samples/4);
lat_north_index=96;
lat_south_index=31;
lon_west_index=157;
lon_east_index=253;


LABELS=zeros(nC*samples,nC);

for j=1:nC
    count=1;
 for i=1:length(idx)
     
    if (idx(i)==j)
        g=reshape(PsiA(:,i),97,66);
        
        G=imresize(g,[28 28]);        
     cluster{j}(:,count)=reshape(G,28*28,1);clear g;clear G
     count=count+1;
    end
 end
end
for i=1:size(PsiAF,2)
    g=reshape(PsiAF(:,i),97,66);
        
        G=imresize(g,[28 28])
 cluster{nC+1}(:,i)=reshape(G,28*28,1); clear g;clear G
end

count=1;
for j=1:nC+1
    for i=1:size(cluster{j},2)
    im_rs(:,count)=cluster{j}(:,i);
    LABELS(count,j)=1;
    count=count+1;
    if(i>samples)
        break;
    end
    end
end
%im_rs=im_rs/(max(max(im_rs)));
im_rs=(im_rs-mean(im_rs(:)))/std(im_rs(:));
for i=1:nC+1

   X_train{i}=im_rs(:,(i-1)*samples+1:floor(3*(i*samples-(i-1)*samples)/4)+(i-1)*samples+1);
   Y_train{i}=LABELS((i-1)*samples+1:floor(3*(i*samples-(i-1)*samples)/4)+(i-1)*samples+1,:);
   X_test{i}=im_rs(:,ceil(3*(i*samples-(i-1)*samples)/4)+(i-1)*samples+1:i*samples);
   Y_test{i}=LABELS(ceil(3*(i*samples-(i-1)*samples)/4)+(i-1)*samples+1:i*samples,:);

 end

 XX_train=[];XX_test=[];YY_train=[];YY_test=[];
 for i=1:nC+1
     XX_train=[XX_train X_train{i}];
     YY_train=[YY_train;Y_train{i}];
     XX_test=[XX_test X_test{i}];
     YY_test=[YY_test;Y_test{i}];

 end

 idx=randperm(size(XX_train,2));
 idx2=randperm(size(XX_test,2));
% %x=x(randperm(length(x)));
 IMAGE_shuffle_train=XX_train(:,idx);
 IMAGE_shuffle_test=XX_test(:,idx2);
 LABELS_shuffle_train=YY_train(idx,:);
 LABELS_shuffle_test=YY_test(idx2,:);

save('savedata_for_training_40ensemble_4classes_bigbox_anomaly_timeanomalies.mat','IMAGE_shuffle_train','LABELS_shuffle_train','IMAGE_shuffle_test','LABELS_shuffle_test','-v7.3'); 
csvwrite('training_40ensemble_4classes_anomaly_forTRUEandFalse_matrix_bicubic.csv',IMAGE_shuffle_train); 
csvwrite('labels_40ensemble_4classes_anomaly_forTRUEandFalse_matrix_bicubic.csv',LABELS_shuffle_train); 
 
csvwrite('test_40ensemble_4classes_anomaly_forTRUEandFalse_matrix_bicubic.csv',IMAGE_shuffle_test); 
csvwrite('test_labels_40ensemble_4classes_anomaly_forTRUEandFalse_matrix_bicubic.csv',LABELS_shuffle_test); 
