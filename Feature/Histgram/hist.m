clc;
clear all;
close all;
%% 绘制直方图和直方图均衡化提高图像的对比度
I=imread('baboon.jpg');
grayimg=rgb2gray(I);

figure;imshow(grayimg);
figure;
[counts,x]=imhist(grayimg,16); %绘制直方图
stem(x,counts);

J=histeq(grayimg); %直方图均衡化
figure;imshow(J);
figure;
[counts,x]=imhist(J,16); %绘制均衡化后的直方图
stem(x,counts);

% 对比度调整
L=imadjust(grayimg,[0.3,0.7],[]);
figure;
imshow(L);
figure;
[counts,x]=imhist(J,16); %绘制对比度后的直方图
stem(x,counts);
