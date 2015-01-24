%% 二维小波分解和重构可以用一系列的一维小波分解和重构来实现，以下程序是基于Harr小波的二维分解和重构过程
%%
function [LL,HL,LH,HH]=mydwt2(x)
% 函数 MYDWT2() 对输入的r*c维矩阵 x 进行二维小波分解，输出四个分解系数子矩阵[LL,HL,LH,HH]
% 输入参数：x —— 输入矩阵，为r*c维矩阵。
% 输出参数：LL,HL,LH,HH —— 是分解系数矩阵的四个相等大小的子矩阵,大小均为 r/2 * c/2 维
%               LL：低频部分分解系数；    HL：垂直方向分解系数；
%               LH：水平方向分解系数；    HH：对角线方向分解系数。

lpd=[1/2 1/2];hpd=[-1/2 1/2];           % 默认的低通、高通滤波器
[row,col]=size(x);                      % 读取输入矩阵的大小

for j=1:row                             % 首先对输入矩阵的每一行序列进行一维离散小波分解
    tmp1=x(j,:);
    [ca1,cd1]=mydwt(tmp1,lpd,hpd,1);
    x(j,:)=[ca1,cd1];                   % 将分解系数序列再存入矩阵x中，得到[L|H]
end
for k=1:col                             % 再对输入矩阵的每一列序列进行一维离散小波分解
    tmp2=x(:,k);
    [ca2,cd2]=mydwt(tmp2,lpd,hpd,1);
    x(:,k)=[ca2,cd2];                   % 将分解所得系数存入矩阵x中，得到[LL,Hl;LH,HH]
end

LL=x(1:row/2,1:col/2);                  % LL是矩阵x的左上角部分
LH=x(row/2+1:row,1:col/2);              % LH是矩阵x的左下角部分
HL=x(1:row/2,col/2+1:col);              % HL是矩阵x的右上角部分
HH=x(row/2+1:row,col/2+1:col);          % HH是矩阵x的右下角部分