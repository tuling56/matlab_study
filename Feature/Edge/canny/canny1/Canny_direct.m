clear all; close all; clc;

InputImg=dir('Sample/testpics/*.JPG');
fid=fopen('timing.txt','w');
for i=1:length(InputImg)
   i
OutputImg=strcat('Sample/testpics/results/',InputImg(i).name,'_1.JPG');
img=imread(strcat('Sample/testpics/',InputImg(i).name));
grayimg=rgb2gray(img);

% 手动阈值设置
% thresholdratio=0.4;
% lowthresh=0.0300;
% highthresh=0.0300*thresholdratio;
% thresh=[lowthresh,highthresh];
% sigma=2;

%自动阈值设置
tic;
  %cannyimg=edge(grayimg,'canny',thresh,sigma);
  [cannyimg,thresh]=edge(grayimg,'canny');
  thresh
 fprintf(fid,'%s \n',InputImg(i).name);
 fprintf(fid,'\tthresh:[%s,%s]\n',num2str(thresh(1)),num2str(thresh(2))); 
 fprintf(fid,'\ttime: %s\n',num2str(toc));
 fprintf(fid,'----------------------------');
 
 imwrite(cannyimg,OutputImg)
% figure,imshow(img);
% figure;imshow(cannyimg);
end
 fclose(fid);