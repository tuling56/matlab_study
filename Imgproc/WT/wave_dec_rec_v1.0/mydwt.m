function [cA,cD] = mydwt(x,lpd,hpd,dim)
% 函数 [cA,cD]=MYDWT(X,LPD,HPD,DIM) 对输入序列x进行一维离散小波分解，输出分解序列[cA,cD]
% 输入参数：x——输入序列；
%          lpd——低通滤波器；
%          hpd——高通滤波器；
%          dim——小波分解级数。
% 输出参数：cA——平均部分的小波分解系数；
%           cD——细节部分的小波分解系数。

cA=x;       % 初始化cA，cD
cD=[];
for i=1:dim
    cvl=conv(cA,lpd);   % 低通滤波，为了提高运行速度，调用MATLAB提供的卷积函数conv()
    dnl=downspl(cvl);   % 通过下抽样求出平均部分的分解系数
    cvh=conv(cA,hpd);   % 高通滤波
    dnh=downspl(cvh);   % 通过下抽样求出本层分解后的细节部分系数
    cA=dnl;             % 下抽样后的平均部分系数进入下一层分解
    cD=[cD,dnh];        % 将本层分解所得的细节部分系数存入序列cD
end

function y=downspl(x)
% 函数 Y=DOWMSPL(X) 对输入序列进行下抽样，输出序列 Y。
% 下抽样是对输入序列取其偶数位，舍弃奇数位。例如 x=[x1,x2,x3,x4,x5]，则 y=[x2,x4].

N=length(x);        % 读取输入序列长度
M=floor(N/2);        % 输出序列的长度是输入序列长度的一半（带小数时取整数部分）
i=1:M;
y(i)=x(2*i);

