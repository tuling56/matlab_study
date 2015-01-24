%% 本程序只有分解没有融合（重构），在本程序里有三个matlab函数

function GaussPyramid(imgname)
%对源图像进行Gauss金字塔分解
imbase=imread(imgname); %读入原始图像

imsmooth=OGuassion(imbase); %低通滤波
im1=ODownSample(imsmooth);  %下采样
im1=uint8(im1);
imwrite(im1,'Gauss128.jpg');    %将数据写回图像文件中

%以下分解两次，每分解一次，长宽同时缩小两倍
imsmooth=OGuassion(im1);
im1=ODownSample(imsmooth);
im1=uint8(im1);
imwrite(im1,'Gauss64.jpg'); 

imsmooth=OGuassion(im1); %%%调用子函数
im1=ODownSample(imsmooth);%%%调用子函数
im1=uint8(im1);
imwrite(im1,'Gauss32.jpg');

%将源图像和分解所得的图像显示出来
subplot('position',[0.05,0.2,0.4,0.6]);
image(imbase);
title('原始图像');

subplot('position',[0.5,0.2,0.2,0.3]);
imbase1=imread('Gauss128.jpg');
image(imbase1);
title('Gauss128');

subplot('position',[0.75,0.2,0.1,0.15]);
imbase2=imread('Gauss64.jpg');
image(imbase2);
title('Gauss64');

subplot('position',[0.9,0.2,0.05,0.075]);
imbase3=imread('Gauss32.jpg');
image(imbase3);
title('Gauss32');


%------------------------------子函数的实现--------------------------------
%对图像im进行高斯低通滤波
function r=OGuassion(im)
radius=5;
sigma=1;
%创建一个二维Gaussian低通滤波器，它是一个大小为2*radius+1，标准差为sigma
%的旋转对称矩阵。GaussianS为返回的卷积核
GaussianS=fspecial('gaussian',2*radius+1,sigma);

im=double(im);  %强制转换为双精度类型
[m,n,z]=size(im);%将im的每个维度的大小分别赋予变量m,n,z
for i=1:z
    GaussianSmooth(:,:,i)=GaussianS;
end
r=zeros(m,n,z);
for i=1:m
    for j=1:n
        %对称构成图像的小块区域
        row=i-radius:i+radius;
        if i-radius<1
            row(1:radius-i+1)=i+radius:-1:2*i;
        end
        if i+radius>m
            row(radius+m-i+2:2*radius+1)=i-radius:2*i-m-1;
        end
        col=j-radius:j+radius;
        if j-radius<1
            col(1:radius-j+1)=j+radius:-1:2*j;
        end
        if j+radius>n
            col(radius+n-j+2:2*radius+1)=j-radius:2*j-n-1;
        end 
        r(i,j,:)=sum(sum(im(row,col,:).*GaussianSmooth(:,:,:))); 
    end
end


%降2向下采样
function r=ODownSample(im)
[m,n,z]=size(im);
r=im(2:2:m,2:2:n,:); 



