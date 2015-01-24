%对一幅图像I进行M尺度的小波变换
clc; close all;clear all
I=imread('Fig7.01.jpg');


M=3;% M----小波变换的尺度
I1=double(I);
[m,n]=size(I);
Iout=zeros(size(I));
% W1=zeros(size(I));
%=============Haar wavelete transform==================
W1=I1;
for k=1:M
    for i=1:n
        W1(:,i)=selfdwt(W1(:,i),1);%对列进行变换
    end
    for i=1:m
        W1(i,:)=selfdwt(W1(i,:),1);%对行进行变换
    end
    
    for i=1:m
        for j=1:n
            Iout(i,j)=W1(i,j);%新数据
        end
    end
    m=m/2; n=n/2;
    W1=zeros(m,n);
    for i=1:m
        for j=1:m
            W1(i,j)=Iout(i,j);
        end
    end
end
%======================================================
%========================scaling=======================
[m,n]=size(I);
min=0;
for i=1:m
    for j=1:n
        if(Iout(i,j)<min)
           min=Iout(i,j);
       end
   end
end
Iout1=(Iout+abs(min))*.5;
max=255;
for i=1:m
    for j=1:n
        if(Iout1(i,j)>max)
            max=Iout1(i,j);
        end
    end
end
if(max>255)
    Iout1=(Iout1*(255/max)).*2;
end
%======================================================
Iout1(:,256)=255;
Iout1(256,:)=255;
Iout1(1:256,128)=255;
Iout1(128,1:256)=255;
Iout1(1:128,64)=255;
Iout1(64,1:128)=255;

figure
imshow(uint8(Iout.*28))
title('before scaling');

figure
imshow(uint8(Iout1));
title('after scaling')

Iout2=imidwt2(Iout,M);
figure
imshow(uint8(Iout2));
title('小波重构后的图')