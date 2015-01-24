%% 基于块分析的二值化算法 
% 参考：http://blog.csdn.net/cxf7394373/article/details/5787946#comments

I = imread('binaryzaimg.bmp');

I = rgb2gray(I);
[m,n] = size(I);

block = 10;
ver = floor(m/block);
hor = floor(n/block);
T = zeros(m,n);
for b_ver = 1:block
    for b_hor = 1: block
%        T((ver * (b_ver - 1)+1) : (ver *b_ver),(hor *(b_hor - 1) + 1):(hor*b_hor)) = otsu(I((ver * (b_ver - 1)+1) : (ver *b_ver),(hor *(b_hor - 1) + 1):(hor*b_hor)));
        t = 0;
        for i = (ver * (b_ver - 1)+1) : (ver * b_ver)
            for j = (hor * (b_hor - 1) + 1):(hor * b_hor)
                t = t + uint32(I(i,j));
            end
        end
        t =  double(t)/(ver * hor);
        std_deviation = 0;
        for i = (ver * (b_ver - 1)+1) : (ver * b_ver)
            for j = (hor * (b_hor - 1) + 1):(hor * b_hor)
                std_deviation = std_deviation + (uint32(I(i,j)) - t)*(uint32(I(i,j)) - t);
            end
        end
        std_deviation = sqrt(double(std_deviation)/(ver*hor));
        
        thr = t + 0.2*std_deviation;
        
        for i = (ver * (b_ver - 1)+1) : (ver * b_ver)
            for j = (hor * (b_hor - 1) + 1):(hor * b_hor)
                if I(i,j) > uint8(floor(thr))
                    T(i,j) = 255;
                else
                    T(i,j) = 0;
                end
            end
        end
    end
end
imshow(T);
