%% 进行测试的程序
% a=3+4;
% B=a+5;
% a=mfilename %返回当前所执行的M文件的文件名

I=imread('1.bmp');
grayimg=rgb2gray(I);
grayimg=double(grayimg);
LoadEnhance(grayimg,1,1);
