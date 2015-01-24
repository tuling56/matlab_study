%%Niblack算法二值化
%参考：http://blog.csdn.net/cxf7394373/article/details/5787908
%处理结果不好，产生了大量噪声

I = imread('binaryzaimg.bmp');
I = rgb2gray(I);

w =  2;%   
max = 0;   
min = 0;   
[m,n] = size(I);   
T = zeros(m ,n );   
  
%
for i = (w + 1):(m - w)   
    for j = (w + 1):(n - w)      
        sum = 0;
        for k = -w:w   
            for l = -w:w   
                sum = sum + uint32(I(i + k,j + l));
            end   
        end   
        average = double(sum) /((2*w+1)*(2*w+1));
        s = 0;
        for k = -w:w   
            for l = -w:w   
                s = s +   (uint32(I(i + k,j + l)) - average)*(uint32(I(i + k,j + l)) - average);
            end   
        end   
        s= sqrt(double(s)/((2*w+1)*(2*w+1)));
        
        T(i,j) = average + 0.2*s;
    end   
end   
for i =  1:m 
    for j = 1:n 
        if I(i,j) > T(i,j)   
            I(i,j) = uint8(255);   
        else  
            I(i,j) = uint8(0);   
        end   
    end   
end   
imshow(I);  