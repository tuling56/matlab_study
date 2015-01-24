%----------------------------------------------------------%
      % 二维小波重构矩阵 Matlab 程序 - V3.0版
%----------------------------------------------------------%
function xrec=mywaverec2(coef,scf,recdim,wname)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 函数 MYWAVEREC2() 对输入的分解系数矩阵x进行 recdim 层重构，得到重构矩阵 xrec
% 输入参数：y —— 分解系数矩阵；
%          recdim —— 重构级数；
%          wname —— 重构所用的小波函数
% 输出参数：xrec —— 重构矩阵。
%
% Copyright by Zou Yuhua ( chenyusiyuan ), Version: 3.0, Date: 2008-07-08
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 
% 求小波函数对应的重构滤波器组系数
[Lo_R,Hi_R] = wfilters(wname,'r');
% 通过小波系数矩阵求出图像的分解级数 decdim
[yr,yc]=size(coef); % 小波系数矩阵 coef 是一个细胞矩阵（cell matrix）,其中有 yr 个子矩阵，yc=1
decdim=(yr-1)/3;    % 图像的 N 级分解会产生 1 个低频矩阵，N*3 个高频矩阵
if decdim<recdim
    error(['Reconstruction level can not larger than decomposition level ( declev = ',num2str(decdim),' )'])
end
 
rcA=coef{1};
for i=1:recdim          % 依次获取第 decdim 级至第（decdim - recdim + 1）级的高频系数矩阵
    rcV=coef{(i-1)*3+2};
    rcH=coef{(i-1)*3+3};
    rcD=coef{(i-1)*3+4};            
    rcA=myidwt2(rcA,rcV,rcH,rcD,Lo_R,Hi_R,scf(i+2,:));           % 第 N 级重构得到第 N-1 级低频系数矩阵 
end
xrec=rcA;                    % 重构结束后得到的矩阵 rcA 即为输出矩阵 xrec
 
plotxrec(decdim,recdim,xrec)
 
 
function plotxrec(decdim,recdim,xrec)
figure;
xr=uint8(xrec);            % 将矩阵xrec的数据格式转换为适合显示图像的uint8格式
[sr,sc]=size(xr);
imshow(xr);
title(['Reconstructed Image. DecLevel = ',num2str(decdim),' , RecLevel = ',num2str(recdim)]);
xlabel(['Size : ',num2str(sr),'*',num2str(sc)]);    % 显示重构矩阵的大小
 
 
 
function outcA=myidwt2(rcA,rcV,rcH,rcD,Lo_R,Hi_R,scf)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 函数 MYIDWT2() 对输入的子矩阵序列进行逆小波变换，重构出矩阵 y
% 输入参数：rcA,rcV,rcH,rcD —— 第 N 级低频、高频系数矩阵
%          Lo_R,Hi_R —— 图像重构用到的低通、高通滤波器系数
%          scf —— 本级小波分解系数矩阵的大小
% 输出参数：outcA —— 第 N-1 级低频系数矩阵，当N-1=0时即为重构图像。
%
% Copyright by Zou Yuhua ( chenyusiyuan ), Version: 3.0, Date: 2008-07-08
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% 将四个第 N 级系数矩阵组合成一个矩阵
tmp_mat=[rcA,rcV;rcH,rcD];
[row,col]=size(tmp_mat);
% 这里 tmp_mat 的行列数比第 N-1 级低频矩阵 cA(N-1) 的要长 lf-1 行（列）
% 求出滤波器的长度
lf=length(Lo_R);
 
for k=1:col                             % 首先对组合矩阵tmp_mat的每一列，分开成上下两半
    ca1=tmp_mat(1:row/2,k);             % 分开的两部分分别作为平均系数序列ca1、细节系数序列cd1
    cd1=tmp_mat(row/2+1:row,k);         % ca1、cd1的长度恰好等于tmp_mat的行数row
    tmp1=myidwt(ca1,cd1,Lo_R,Hi_R);     % 重构序列的长度是（row+lf-1）
    % 通过Matlab函数wkeep()截取与分解级相应的系数序列长度
    yt1(:,k)=wkeep(tmp1,scf(1));    % 截取后的重构序列存入缓存矩阵
end
[row1,col1]=size(yt1);
 
for j=1:row1                        % 将缓存矩阵 yt1 的每一行，分开成左右两半
    ca2=yt1(j,1:col1/2);            % 分开的两部分分别作为平均系数序列ca2、细节系数序列cd2
    cd2=yt1(j,col1/2+1:col1);
    tmp2=myidwt(ca2,cd2,Lo_R,Hi_R);  
    outcA(j,:)=wkeep(tmp2,scf(2));    % 2008-07-07 test
    % 同理，也要截取 tmp2 中间长度为scf(2)的那一段，存入输出矩阵 outcA
end
 
 
 
function y = myidwt(cA,cD,lpr,hpr);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 函数 MYIDWT() 对输入的小波分解系数进行逆离散小波变换，重构出信号序列 y
% 输入参数：cA —— 平均部分的小波分解系数；
%           cD —— 细节部分的小波分解系数；
%           lpr、hpr —— 重构所用的低通、高通滤波器。
%
% Copyright by Zou Yuhua ( chenyusiyuan ), Version: 1.0, Date: 2007-11-10
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 函数 Y = UPSPL(X) 对输入的一维序列x进行上抽样，即对序列x每个元素之间
% 插零，例如 x=[x1,x2,x3,x4],上抽样后为 y=[0,x1,0,x2,0,x3,0,x4,0];
%
% Copyright by Zou Yuhua ( chenyusiyuan ), Version: 2.0, Date: 2008-07-08
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
N=length(x);        % 读取输入序列长度
M=2*N+1;            % 输出序列的长度是输入序列长度的2倍再加一       
y=zeros(1,M);
k=1:N;
y(2*k)=x(k); % 输出序列的奇数位为0，偶数位按次序等于相应位置的输入序列元素
