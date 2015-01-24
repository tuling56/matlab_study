
% Gaborforfolder.m

clear all;
close all;

%%
Gaborsetting;
%% get original img data
tr_dir=uigetdir('select the data sets...');
% [priPath,dset]=priorPath(tr_dir);
[sfname,spath]=uiputfile('.mat','save file','gabordata');

img_dir = dir([tr_dir,'\*.bmp']);
img_num = length(img_dir);

names=cell(1,img_num);
img_num
for ii=1:img_num
    fname=img_dir(ii).name;
    imgdata=imread([tr_dir,'\',fname]);
    if ii==1
        [h,w]=size(imgdata);
        data=zeros(h,w,img_num);
    end
    data(:,:,ii)=imgdata;
    names{ii}=fname;
end

size(data)
%% Gabor
ipts.dat=data;
clear data;

[data] = Create_GaborF (ipts, par);
data=data.gdat;

save(fullfile(spath,sfname),'data');

clear all;
close all;