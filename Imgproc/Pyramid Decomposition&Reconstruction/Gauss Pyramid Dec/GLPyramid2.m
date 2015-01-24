function GLPyramid2(imgname)

close all % close all the figure windows
%% 这是一条交互matlab交互命令
%name=input('input image name: ','s'); % input the name of image
%G0=imread(name); % load image

%% 分解

G0=imread(imgname); % load image
w1=fspecial('gaussian',5,0.5); % generate gaussian mask
w2=fspecial('gaussian',5,1);
w3=fspecial('gaussian',5,2);
w4=fspecial('gaussian',5,4);

G0=im2double(G0); % translate image data from uint8 to double
G1=imfilter(G0,w1,'replicate');
G2=imfilter(G0,w2,'replicate');
G3=imfilter(G0,w3,'replicate');
G4=imfilter(G0,w4,'replicate');

figure('Name','低通滤波后图像')
subplot(2,3,1); imshow(G0,[])
subplot(2,3,2); imshow(G1,[])
subplot(2,3,3); imshow(G2,[])
subplot(2,3,4); imshow(G3,[])
subplot(2,3,5); imshow(G4,[])

G1=G1(1:2:end,1:2:end);
G2=G2(1:4:end,1:4:end);
G3=G3(1:8:end,1:8:end);
G4=G4(1:16:end,1:16:end);

figure('Name','高斯金字塔')
subplot(2,3,1); imshow(G0,[])
subplot(2,3,2); imshow(G1,[])
subplot(2,3,3); imshow(G2,[])
subplot(2,3,4); imshow(G3,[])
subplot(2,3,5); imshow(G4,[])

t0=imresize(G1,2);%内插法
t1=imresize(G2,2);
t2=imresize(G3,2);
t3=imresize(G4,2);

%拉普拉斯金字塔
L0=G0-t0; %这里存在着维度不匹配的情况
L1=G1-t1;
L2=G2-t2;
L3=G3-t3;
L4=G4;

figure('Name','拉普拉斯金字塔')
subplot(2,3,1); imshow(L0,[])
subplot(2,3,2); imshow(L1,[])
subplot(2,3,3); imshow(L2,[])
subplot(2,3,4); imshow(L3,[])
subplot(2,3,5); imshow(L4,[])

% 拉普拉斯金字塔重构原图像recover the original image
RImg=imresize(G4,2)+L3;
RImg=imresize(RImg,2)+L2;
RImg=imresize(RImg,2)+L1;
RImg=imresize(RImg,2)+L0;
figure
imshow(RImg,[])
