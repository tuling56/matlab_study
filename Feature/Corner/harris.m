% Harris角点检测
%来自于：http://www.cnblogs.com/tiandsp/archive/2012/04/09/2439678.html

close all;
clear all;
clc;

img=imread('rice.jpg'); %要求是灰度图
imshow(img);
[m n]=size(img);

tmp=zeros(m+2,n+2);
tmp(2:m+1,2:n+1)=img;
Ix=zeros(m+2,n+2);
Iy=zeros(m+2,n+2);

E=zeros(m+2,n+2);

Ix(:,2:n)=tmp(:,3:n+1)-tmp(:,1:n-1);
Iy(2:m,:)=tmp(3:m+1,:)-tmp(1:m-1,:);

Ix2=Ix(2:m+1,2:n+1).^2;
Iy2=Iy(2:m+1,2:n+1).^2;
Ixy=Ix(2:m+1,2:n+1).*Iy(2:m+1,2:n+1);

h=fspecial('gaussian',[7 7],2);
Ix2=filter2(h,Ix2);
Iy2=filter2(h,Iy2);
Ixy=filter2(h,Ixy);

Rmax=0;
R=zeros(m,n);
for i=1:m
    for j=1:n
        M=[Ix2(i,j) Ixy(i,j);Ixy(i,j) Iy2(i,j)];
        R(i,j)=det(M)-0.06*(trace(M))^2;
        
        if R(i,j)>Rmax
            Rmax=R(i,j);
        end
    end
end
re=zeros(m+2,n+2);

tmp(2:m+1,2:n+1)=R;
img_re=zeros(m+2,n+2);
img_re(2:m+1,2:n+1)=img;
for i=2:m+1
    for j=2:n+1
        
        if tmp(i,j)>0.01*Rmax &&...
           tmp(i,j)>tmp(i-1,j-1) && tmp(i,j)>tmp(i-1,j) && tmp(i,j)>tmp(i-1,j+1) &&...
           tmp(i,j)>tmp(i,j-1) && tmp(i,j)>tmp(i,j+1) &&...
           tmp(i,j)>tmp(i+1,j-1) && tmp(i,j)>tmp(i+1,j) && tmp(i,j)>tmp(i+1,j+1)
                img_re(i,j)=255; 
        end
          
    end
end

figure,imshow(mat2gray(img_re(2:m+1,2:n+1)));