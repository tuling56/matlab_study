%% 边缘密度检测代码 
% 来自百度知道：http://zhidao.baidu.com/link?url=QqviuMldTkCSmg2Fr-FOb2vnbFdCHcE6-m_xA9Q9t37yJBiK2S30XU1WL2N4we5Kq6hnnD6jcRtp307IzfoIz_

P=imread('density.png');
I=rgb2gray(P);%转换为灰度图像
I=edge(I,'robert','vertical');%用robert算子检测竖直方向的边缘，边缘检测后的图是二值图
imwrite(I,'edge_robert_ver.jpg');
figure(1),subplot(1,2,1),imshow(I);title('原始的竖直边缘检测图');
[m n]=size(I);

K=I;
w=9;%窗口宽度，高度是1个像素
threshold=5;%选择是否连接的阈值，根据情况调整
left=ceil(w/2); %ceil函数时向大数方向，floor是向小数方向，round是四舍五入
right=n-left;

%如果窗口宽度（9）内的边缘像素超过threshold(5),则置窗口内的所有的像素为边缘像素
for i=1:m
    for j=left:right
        if sum(I(i,(j-left+1):(j+left-1)))>=threshold %将密度大于阈值的连接
            K(i,(j-left+1):(j+left-1))=1;
        end
    end
end
figure(1),subplot(1,2,2),imshow(K);title('进行边缘连接后的图');
% K为连接边界后的图像


%% 形态学开闭运算
%开运算
se=strel('rectangle',[m,n]);
I=imopen(I,se);

%闭运算
se=strel('rectangle',[3,2]);
I=imclose(I,se);


% [m,n]为选择的m*n运算矩阵
%也可以直接令se=[]自己想用的预算矩阵
%如[1 0 0;0 1 0;0 0 1];