% 图像直方图局部增强法
% Igray:灰度图像
% k0,k1：可调参数
% Ibw：提取得到数字区域
function Ibw = LocalEnhance(Igray, k0, k1)
masksize = 3; % 邻域范围，奇数
exsize = floor(masksize/2); % 原图片需要填充的区域
Iex = padarray(Igray, [exsize exsize], 'replicate', 'both'); % 图片填充
Is = zeros(size(Igray)); % 局部标准差
for i = 1:size(Igray, 1)
for j = 1:size(Igray, 2)
subdomain = Iex(i:i+2*exsize, j:j+2*exsize);
localmean = sum(subdomain(:))/masksize^2;
Is(i, j) = sqrt(sum((subdomain(:)-localmean).^2))/masksize;
end
end
% 确定不同区域的放大系数
meanIm = mean(Igray(:));
minIm = min(Igray(:));
meanIs = mean(Is(:));
maxIs = max(Is(:));
Im1 = Igray<(minIm+k0*(meanIm-minIm)); % 均值阈值提取
Is1 = Is>(meanIs + k1*(maxIs-meanIs)); % 标准差阈值提取
s = strel('disk',8); % 8需要根据实际图片大小来调
Is1 = imclose(Is1, s); % 标准差阈值提取闭运算
Ibw = Im1 & Is1; % 局部增强
end