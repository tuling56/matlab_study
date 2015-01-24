%% 文件夹的图像连续处理
clc
clear all

% setting.Path.Home='../';
% % add the library for image
% setting.Path.OriginalImages = fullfile(setting.Path.Home,'OriginalImages');
% addpath(setting.Path.OriginalImages);
% setting.Path.OutputImages = fullfile(setting.Path.Home,'OutputImages');
% addpath(setting.Path.OutputImages);
% filelist = readImages(setting.Path.OriginalImages);

filename=dir('../test/*.JPG');
 for i=1:length(filename)
         I=imread(strcat('../test/',filename(i).name));
         str = strcat('../test/',num2str(i),'.bmp');
         imwrite(I,str,'bmp');
%          figure,imshow(I);
 end
%
% for k=1:length(filelist)
% %        filename = fullfile(setting.Path.OriginalImages,filelist(k).name(1:end-4));
%        im = imread(fullfile(setting.Path.OriginalImages,filelist(k).name()));
%        TestImage = strcat('.\M00模糊脸\',num2str(k),'.bmp');
%        imwrite(uint8(tvector),TestImage,'bmp'); 
% end
%