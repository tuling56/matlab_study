%用小波方法图像文字提取
close all
clear all
clc
%wavm='db1';
%wavm='db2';
%wavm='db3';
%wavm='db4';
%wavm='sym2';
%wavm='sym45';
%wavm='bior3.7';
wavm='bior6.8';
x=imread('video_1.JPG');
%x=imread('at.jpg');
%x=rgb2gray(x);
%subplot(331);
%imshow(x);
%title('灰度图像');
%以下是小波分解与系数提取重建等等
%[c,s]=wavedec2(x,2,wavm);
load kt3;
%load at;
subplot(331);
image(x);
colormap(map);
title('原图');

nbl=size(map,1);

a1=appcoef2(coefs,sizes,wavm,1);
h1=detcoef2('h',coefs,sizes,1);
v1=detcoef2('v',coefs,sizes,1);
d1=detcoef2('d',coefs,sizes,1);

ca1=wrcoef2('a',coefs,sizes,wavm,1);
ch1=wrcoef2('h',coefs,sizes,wavm,1);
cv1=wrcoef2('v',coefs,sizes,wavm,1);
cd1=wrcoef2('d',coefs,sizes,wavm,1);

ca2=wrcoef2('a',coefs,sizes,wavm,2);
ch2=wrcoef2('h',coefs,sizes,wavm,2);
cv2=wrcoef2('v',coefs,sizes,wavm,2);
cd2=wrcoef2('d',coefs,sizes,wavm,2);

x=waverec2(coefs,sizes,wavm);
subplot(332);
image(x);
colormap(map);
title('小波分解后重建的图像');

xcj=[ca1,ch1;cv1,cd1];
subplot(333);
image(xcj);
colormap(map);
title('小波分解后的图像');

coefs(1:(sizes(1,1)*sizes(1,2)))=0;
xrdp=waverec2(coefs,sizes,wavm);
subplot(334);
image(xrdp);
colormap(map);
title('将低频系数置零后重建的图像');

subplot(335);
xr1=ch1+cv1;
image(xr1);
colormap(map);
title('一尺度水平与竖直的重建');


subplot(336);
xr2=ch2+cv2;
image(xr2);
colormap(map);
title('二尺度水平与竖直的重建');

%x=im2uint8(x);   %转换为int8型

[l1,l2]=size(x);
%************************************************************************%
%根据所设的阈值进行二值化
%************************************************************************%
for i=1:l1
    for j=1:l2
        if 10<abs(xr1(i,j))
            xr1(i,j)=240;
        else xr1(i,j)=0;
        end
    end
end
subplot(337);
image(xr1);
colormap(map);
title('一尺度水平与竖直重建之后分割的图像');
%*************************************************************************%
% 进行腐蚀膨胀处理
%*************************************************************************%
se=strel('line',4,45);
xr1=imerode(xr1,se);
%xr1=imdilate(x2,se);
subplot(338);
image(abs(xr1));
colormap(map);
title('上图腐蚀之后的结果');
%************************************************************************%
%联通区域标记
%************************************************************************%
xr1=im2bw(xr1);
[l,num]=bwlabel(xr1);
sl=regionprops(l,'all');
ts(1:num)=0;
for k=1:num
    if sl(k).Area>1 && sl(k).Area<3000
     if (sl(k).MajorAxisLength./sl(k).MinorAxisLength)<6         
      
         for i=1:l1
          for j=1:l2
                    if l(i,j)==k l(i,j)=255;
                    end
            end
     end
     end
     end
end

  for i=1:l1
        for j=1:l2
              if l(i,j)<255   l(i,j)=0;
              end
            end
  end 
    
subplot(339);
imshow(l,colormap);
title('去掉之后');
%************************************************************************%
%根据所设的阈值进行二值化
%************************************************************************%
for i=1:l1
    for j=1:l2
        if 15<(xr2(i,j))
            xr2(i,j)=240;
        else xr2(i,j)=0;
        end
    end
end
figure,
subplot(331);
image(xr2);
colormap(map);
title('二尺度重建之后分割的图像');
%*************************************************************************%
%
%*************************************************************************%
se=strel('disk',10);
ld=imdilate(l,se);
subplot(332);
image(ld);
title('砖石型矩阵结构元素膨胀的结果');

%**************************************************************************
[l3,num]=bwlabel(ld);
sl2=regionprops(l3,'Area');
for k=1:num
    if sl2(k).Area>8000
          for i=1:l1
          for j=1:l2
                    if l3(i,j)==k l3(i,j)=255;
                    end
            end
     end
     end
     end

for i=1:l1
        for j=1:l2
              if l3(i,j)<255   l3(i,j)=0;
              end
            end
  end 
    
subplot(333);
imshow(l3);
title('去掉膨胀之后小的面积');


se=strel('disk',10);
l3=imerode(l3,se);

[r,c]=find(l3==255);
a1=max(r);a2=min(r);
b1=max(c);b2=min(c);
w=b1-b2;h=a1-a2; 


for i=1:l1
        for j=1:l2
            if (i>a2) && (i<a1) && (j>b2) && (j<b1)
              x(i,j)=x(i,j);  xr1(i,j)=xr1(i,j);
            else 
                x(i,j)=0;xr1(i,j)=0;
            end
        end
end
subplot(334);
imshow(x);
title('一尺度图上的划定');

[r,c]=find(xr1~=0);
a1=max(r);a2=min(r);
b1=max(c);b2=min(c);
w=b1-b2;h=a1-a2; 
b2=b2+1;
a2=a2+1;
b1=b1+1;
b2=b2+1;
rectangle('Position',[b2,a2,w,h],'LineWidth',1,'EdgeColor','r');%画矩形框
subplot(335);
imshow(xr1);
title('最后处理结果');

se=strel('disk',2);
xr1=imdilate(xr1,se);
subplot(336);
imshow(xr1);
title('砖石型结构元素膨胀的结果');
subplot(337);
image(x);
title('原图上划定');