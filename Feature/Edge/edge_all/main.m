clear;
clc;
I=imread('lena.bmp');
size_I=size(I);
isgrb=size(size_I);
if isgrb(2)==3
    I=rgb2gray(I);
end
prompt={'1、robert 2、prewitt 3、sobel 4、marr 5、canny'};
title='Input the operator number';
lines=1;
resize='on';
typenum=inputdlg(prompt,title,lines);
s=str2mat(typenum);
type=str2num(s);
if type==1
    ans=robert(I);
    imshow(ans);
elseif type==2
    ans=prewitt(I);
    imshow(ans);
elseif type==3
    ans=sobel(I);
    imshow(ans);
elseif type==4
    ans=marr(I);
    imshow(ans);
elseif type==5
    ans=canny(I);
    imshow(ans);
elseif type==6
    ans1=robert(I);
    subplot(2,3,1);
    imshow(ans1);
    ans2=prewitt(I);
    subplot(2,3,2);
    imshow(ans2);
    ans3=sobel(I);
    subplot(2,3,3);
    imshow(ans3);
    ans4=marr(I);
    subplot(2,3,4);
    imshow(ans4);
    ans5=canny(I);
    subplot(2,3,6);
    imshow(ans5);
end