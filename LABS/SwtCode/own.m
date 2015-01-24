% canny edge detection
% gradient for canny image
% stroke width detection
% connected component grouping.

clc;
clear all;
close all;
I=imread('2.jpg');
imshow(I);
I1=rgb2gray(I);
ed=edge(I1,'canny',0.4);
[gx gy]=gradient(double(ed),0.5);
gm=sqrt(gx.^2+gy.^2);%计算每一点的梯度大小
gdp=atan2(gy,gx);%计算每一点的梯度方向
figure;
imshow(gm);
[r c]=size(gdp);
%if pixel p lies on the stroke boundary,then gdp(gradient direction) must be perpendicular to the orientation of the stroke
for i=1:r
  for j=1:c
    if gdp(i,j)==ed(i,j) 
       ray(i,j)=gm(i,j)+1*gdp(i,j);
    end 
  end
end