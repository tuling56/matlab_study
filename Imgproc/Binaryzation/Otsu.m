%% 大律法自适应阈值分割方法
%参考网址：http://blog.sina.com.cn/s/blog_6163bdeb0102e8po.html
% 
% I=imread('1.bmp');
% GrayIm=rgb2gray(I)'
% % GrayIm为0-255的灰度图
% [graydata, grayindex]=imhist(GrayIm);
% graydata = graydata(:)';
% mingray=find(graydata>0, 1, 'first');
% maxgray=find(graydata>0, 1, 'last');
% g = zeros(1, maxgray-mingray+1);
% for t=mingray:maxgray
% w0=sum(graydata(mingray:t))/sum(graydata(mingray:maxgray));
% u0=sum((mingray:t).*graydata(mingray:t))/sum(graydata(mingray:t));
% w1=1-w0;
% u1=sum((t:maxgray).*graydata(t:maxgray))/sum(graydata(t:maxgray));
% u=w0*u0+w1*u1;
% g(t)=w0*(u0-u)^2+w1*(u1-u)^2;
% end
% [C I]=max(g);
% t = mingray:maxgray;
% grayThresh=grayindex(t(I)-1);

 
% 实际上matlab提供了相关函数来实现，即函数graythresh，它的计算结果和上面的代码相差不大，仅供参考吧！
%一个例子：
I = imread('binaryzaimg.bmp');
I =rgb2gray(I);
figure
imshow(I)
title('原始图像')
figure
imhist(I)
title('灰度图像的直方图')
level = graythresh(I)
BW = im2bw(I,level);
figure
imshow(BW)
title('根据动态阈值做二值化')