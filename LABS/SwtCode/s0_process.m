%% 主要是图像灰度化和边缘检测的处理
%Input ori_gray.jpg(2-div gray) , canny.jpg (edge binary).
% OriImage =  (imread('ori_gray.jpg'))';
% EdgeImage = (imread('canny.jpg'))';
% 
clc;
clear all;

Pic = imread('signs2.jpg');
if length(size(Pic))==3     % 彩色图像转为灰度图像
    Pic_gray= rgb2gray(Pic);
else
    Pic_gray=Pic;
end
imwrite(Pic_gray,'0_gray.png'); 
% canny_num=[175 320]/1250;  %% freedom
canny_num=[175 220]/600;  % 边缘检测参数设置   
Pic_canny= edge(Pic_gray,'canny',canny_num);    % defult 0.3
% Pic_canny= edge(Pic_gray,'canny');

figure,imshow(Pic_canny);
title(['canny para=',num2str(canny_num)]);
saveas(gcf(),'1_canny.png');
% imwrite(Pic_canny,'canny.png');
clear canny_num;

