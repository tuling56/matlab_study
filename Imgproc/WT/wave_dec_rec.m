%% 本程序调用的系统的小波分解wavedec2()和waverec2(),没有调用自己编的,若调用自己编的请替换成mywavedec2()和mywaverec2()
clc;
clear all;
%% 第一层  sym4小波分解和重构
[X,map]=imread('1.bmp');
subplot(1,2,1);
imshow(X);
[c,s]=mywavedec2(X,3,'sym4'); %二维信号的多层（3）小波分解
Csize=size(c);
for i=1:Csize(2)
  if(c(i)>100)  %低频分量----s中第一维的长度
   c(i)=1*c(i);
  else
   c(i)=0.9*c(i);  %高频分量
  end
end
x1=mywaverec2(c,s,'sym4');%二维信号的多重小波重构
im=uint8(x1);
subplot(1,2,2);
imshow(im);
 %%  第二层
[c,s]=mywavedec2(X,2,'bior3.7');%对图像用小波进行层分解
cal=appcoef2(c,s,'bior3.7',1);%提取小波分解（结构中的一层的低频系数）近似分量
ch1=detcoef2('h',c,s,1);%提取二维信号小波分解的水平方向的细节分量 
cv1=detcoef2('v',c,s,1);%垂直方向
cd1=detcoef2('d',c,s,1);%斜线方向
a1=wrcoef2('a',c,s,'bior3.7',1);%各频率成份重构，由多层小波分解重构某一层的分解信号

 
[c,s]=mywavedec2(X,1,'sym4');
a1=appcoef2(c,s,'sym4',1);%小波分解结构中的一层的低频系数，下面是3个高频系数
a1=2*a1;
h1=detcoef2('h',c,s,1);
v1=detcoef2('v',c,s,1);
d1=detcoef2('d',c,s,1);
h1=0.5*h1;
v1=0.5*v1;
d1=0.5*d1;
y=idwt2(a1,h1,v1,d1,'sym4');  %二维离散小波反变换
 
 %%  第三层
load wbarb; 
X1=X;map1=map; 
figure;
subplot(2,2,1); 
image(X1);colormap(map1); 
title('图像wbarb'); 

load woman; 
X2=X;map2=map; 
subplot(2,2,2); 
image(X2);colormap(map2); 
title('图像woman'); 
%===================================== 
%对上述二图像进行分解 
[c1,l1]=mywavedec2(X1,2,'sym4'); 
[c2,l2]=mywavedec2(X2,2,'sym4'); 
c=c1+c2; %对分解系数进行融合 
%===================================== 
%应用融合系数进行图像重构并显示 
XX=mywaverec2(c,l1,'sym4'); 
subplot(2,2,3); 
image(XX); 
title('融合图像1'); 
Csize1=size(c1); 
%===================================== 
%对图像进行增强处理 
for i=1:Csize1(2) 
    c1(i)=1.2*c1(i); 
end 
Csize2=size(c2); 
for j=1:Csize2(2) 
    c2(j)=0.8*c2(j); 
end 
%===================================== 
%通过减小融合系数以减小图像的亮度 
c=0.5*(c1+c2); 
%对融合系数进行图像重构 
XXX=mywaverec2(c,l2,'sym4'); 
%显示重构结果 
subplot(2,2,4); 
image(XXX); 
title('融合图像2'); 
%%  第四层
%本程序实现下述功能：首先读入原始图像，并对它使用db3小波进行2层分解，
%然后对分解系数进行处理，强化所需，弱化不需要的部分
%装载并显示原始图像
clc;
clear all;
load flujet;
figure;
subplot(1,3,1);
image(X);colormap(map);
title('原始图像');
%=====================================
%对图像X用小波db3进行2层分解
[c,l]=mywavedec2(X,2,'db3');
Csize=size(c);
%对分解系数作处理，以突出所需部分并弱化不需要部分
for i=1:Csize(2)
  if(c(i)>300)  %低频分量
   c(i)=2*c(i);
  else
   c(i)=0.5*c(i);  %高频分量
  end
end

%重构图像并显示
X1=mywaverec2(c,l,'db3');
subplot(1,3,2);
image(X1);colormap(map);
title('db3增强图像');
%=====================================
%对图像X用小波sym4进行2层分解
[c,s]=wavedec2(X,2,'sym4');
Csize=size(c);
for i=1:Csize(2)
    if(c(i)>169)  %低频分量----s中第一维的长度
        c(i)=2*c(i);
    else
        c(i)=0.3*c(i);  %高频分量
    end
end
x1=waverec2(c,s,'sym4');
im=uint8(x1);
subplot(1,3,3);
imshow(im);colormap(cool);
title('sym4增强图像');
