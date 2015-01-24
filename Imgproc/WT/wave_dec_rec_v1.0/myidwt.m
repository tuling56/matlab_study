function y = myidwt(cA,cD,lpr,hpr)
% 函数 MYIDWT() 对输入的小波分解系数进行逆离散小波变换，重构出信号序列 y
% 输入参数：cA —— 平均部分的小波分解系数；
%           cD —— 细节部分的小波分解系数；
%           lpr、hpr —— 重构所用的低通、高通滤波器。

lca=length(cA);             % 求出平均、细节部分分解系数的长度
lcd=length(cD);

while (lcd)>=(lca)          % 每一层重构中，cA 和 cD 的长度要相等，故每层重构后，
                            % 若lcd小于lca，则重构停止，这时的 cA 即为重构信号序列 y 。
    upl=upspl(cA);          % 对平均部分系数进行上抽样
    cvl=conv(upl,lpr);      % 低通卷积
    
    cD_up=cD(lcd-lca+1:lcd);    % 取出本层重构所需的细节部分系数，长度与本层平均部分系数的长度相等
    uph=upspl(cD_up);       % 对细节部分系数进行上抽样
    cvh=conv(uph,hpr);      % 高通卷积
    
    cA=cvl+cvh;             % 用本层重构的序列更新cA，以进行下一层重构
    cD=cD(1:lcd-lca);       % 舍弃本层重构用到的细节部分系数，更新cD
    lca=length(cA);         % 求出下一层重构所用的平均、细节部分系数的长度
    lcd=length(cD);
end                         % lcd < lca，重构完成，结束循环
y=cA;                       % 输出的重构序列 y 等于重构完成后的平均部分系数序列 cA

function y=upspl(x)
% 函数 Y = UPSPL(X) 对输入的一维序列x进行上抽样，即对序列x每个元素之间
% 插零，例如 x=[x1,x2,x3,x4],上抽样后为 y=[x1,0,x2,0,x3,0,x4];

N=length(x);        % 读取输入序列长度
M=2*N-1;            % 输出序列的长度是输入序列长度的2倍再减一
for i=1:M           % 输出序列的偶数位为0，奇数位按次序等于相应位置的输入序列元素
    if mod(i,2)
        y(i)=x((i+1)/2);
    else
        y(i)=0;
    end
end