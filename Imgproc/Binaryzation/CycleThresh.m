%% 循环阈值方法实现图像二值化
%参考：http://blog.csdn.net/cxf7394373/article/details/5526049

clc
clear
G = imread('binaryzaimg.bmp');
I = rgb2gray(G);
%l = rgb2gray(h);%转换成灰度图像，得到灰度值
%imhist(img);%得到灰度直方图
%disp(img);%显示各像素的灰度值

%循环阈值选择方法
gray1 = 0;%一部分图像的灰度值之和
gray2 = 0;%另一部分图像的灰度值之和
u1 = 0;%一部分图像的平均灰度值
u2 = 0;%另一部分的平均灰度值
k = 0;%一部分图像的像素个数
r = 0;%另一部分图像的像素个数
x = 0;%阈值和
T = 0;%图像的阈值
[m,n] = size(I)%获取图像大小

%获取平均阈值
for i = 1:m
    for j = 1:n
        x = x + uint32(I(i,j));
    end
end
T = x/(m*n);%初始阈值

T1 = 0;
while T ~= T1 
    T1 = T;
    for i = 1:m
        for j = 1:n
            if I(i,j) < T
                gray1 = gray1 + uint32(I(i,j));
                k = k + 1;
            else 
                gray2 = gray2 + uint32(I(i,j));
                r = r + 1;
            end
        end
    end
    u1 = gray1/k;
    u2 = gray2/r;    
    T = (u1 + u2)/2;%新的阈值
end
%BW = im2bw(g,T);%转换成二值图像
T %输出最后选择的阈值
%显示区域，把不在阈值范围内的点的灰度值置为255
for i = 1:m
    for j = 1:n
        if I(i,j) > T 
            I(i,j) = uint32(255);
        else
            I(i,j) = uint32(0);
        end
    end
end
%se = strel('disk',1);
%h = imclose(I,se);
%h = imdilate(I,se);
%y = imerode(h,se);

%h = medfilt2(I,[3,3];
%imshow(y);
imshow(I);

