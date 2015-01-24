%% Otsu算法进行图像二值化实现程序 
%参考：http://blog.csdn.net/cxf7394373/article/details/5526040

G = imread('binaryzaimg.bmp');
I = rgb2gray(G);

[m,n] = size(I);
Hist = zeros(255);%直方图
dHist = zeros(255);
variance = zeros(255);%方差
PXD = 0;

for i = 1:m
    for j = 1:n
        Hist(uint8(I(i,j))) = Hist(uint8(I(i,j))) + 1;
    end
end

for i = 1:255
    dHist(i) = Hist(i)/(m*n);
end

for PXD = 1:255
    w0 = 0;
    w1 = 0;
    g0 = 0;
    g1 = 0;
    for i = 1:PXD
        g0 = g0 + i*dHist(i);
        w0 = w0 + dHist(i);
    end
    for i = PXD+1 : 255
        g1 = g1 + i*dHist(i);
        w1 = w1 + dHist(i);
    end
    variance(PXD) = w0*w1*(g0 - g1)*(g0 - g1);
end

PXD = 1;
for i = 1:255
    if variance(PXD) < variance(i)
        PXD = i;
    end
end

for  i = 1:m
    for j = 1:n
        if I(i,j) > PXD 
            I(i,j) = 255;
        else
            I(i,j) = 0;
        end
    end
end    
imagBW = I;    
imshow(imagBW);
