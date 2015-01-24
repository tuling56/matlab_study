%----------------------------------------------------------% 
     %二维小波分解矩阵 Matlab 程序 - V3.0版
%----------------------------------------------------------%
 
function [coef,scf]=mywavedec2(x,N,wname)
%----------------------------------------------------------%
% 函数 MYWAVEDEC2() 对输入矩阵 x 进行 dim 层分解，得到相应的分解系数矩阵 y
% 输入参数：x —— 输入矩阵
%          N —— 分解级数
%          wname —— 分解所用的小波函数
% 输出参数：scf —— 存储各级分解系数矩阵的大小以及原始（图像）矩阵的大小
%           coef —— 分解系数矩阵，其结构如下：
% coef = {cA_N;cV_N;cH_N;cD_N;cV_N-1;cH_N-1;cD_N-1;……;cV_1;cH_1;cD_1}
%
% Copyright by Zou Yuhua ( chenyusiyuan )
% Version: 3.0, Date: 2008-07-08
%----------------------------------------------------------%
 
 
% 求出小波函数的滤波器组系数向量
[Lo_D,Hi_D] = wfilters(wname,'d'); 
lf=length(Lo_D);
% 画出原始图像
imshow(x);title('Original Image');
% 标明图像大小
[r,c]=size(x);
xlabel(['Size : ',num2str(r),'*',num2str(c)]);
 
 
% 将矩阵x的数据格式转换为适合数值处理的double格式
xd=double(x);               
[rx,cx]=size(x);
[o2sa,f1sa,rsx]=sizcoef([rx,cx],lf,N);  a=[o2sa,f1sa,rsx]
 
coef=[];
scf=[rx,cx];
for i=1:N
    [cA,cV,cH,cD]=mydwt2(xd,Lo_D,Hi_D);     % 第 i 级小波分解    
    xd=cA;              % 将第 i 级分解得到的低频系数矩阵作为第 i+1 级分解的源矩阵
    outmp={cV;cH;cD};      % 将第 i 级分解得到的高频系数矩阵cV,cH,cD存入细胞矩阵 outmp
    
    scf=[size(cV);scf]; % 将各级分解系数矩阵的大小存入矩阵 scf
    coef=[outmp;coef];       % 将细胞矩阵 outmp 存入输出矩阵 coef，coef将由空矩阵变为细胞矩阵    
end
% 迭代结束后，矩阵 coef 中保存的是各级分解中的高频系数矩阵
% 故需将迭代后得到的矩阵 cA，即第 dim 级低频矩阵存入矩阵 coef
coef=[cA;coef];
scf=[size(cA);scf];
 
 
plotcoef(N,wname,coef);
plotcoef2one(N,wname,coef,rsx);
 
function plotcoef2one(N,wname,coef,rsx)
% 画出小波分解系数的塔式结构图
rsx=rsx(end:-1:1,:);
tmpcoef=[];
tA=wkeep(coef{1},rsx(1,:),'c');
tmpcoef=tA; 
tA=uint8(tA); tA(end,:)=255; tA(:,end)=255;
for j=1:N
    tV=wkeep(coef{(j-1)*3+2},rsx(j,:),'c');
    tH=wkeep(coef{(j-1)*3+3},rsx(j,:),'c');
    tD=wkeep(coef{(j-1)*3+4},rsx(j,:),'c');
    tV=uint8(tV); tH=uint8(tH); tD=uint8(tD); 
    if j<N
        tV(end,:)=255; tV(:,end)=255;
        tH(end,:)=255; tH(:,end)=255;
        tD(end,:)=255; tD(:,end)=255;
    else
        tV(end,:)=255; tH(:,end)=255;
    end
    tmpcoef=[tA,tV;tH,tD];stc=size(tmpcoef);
    if stc>=rsx(j+1,:)
        tA=tmpcoef(1:rsx(j+1,1),1:rsx(j+1,2));
    else
        tmpcoef=tmpcoef([1:end-1,end-2:end-1],[1:end-1,end-2:end-1]);
        tA=tmpcoef(1:rsx(j+1,1),1:rsx(j+1,2));
    end
    tA=uint8(tA); tA(end,:)=255; tA(:,end)=255;
end
figure;
sc=tA;
[rx,cx]=size(sc);
imshow(sc);
xlabel(['Size : ',num2str(rx),'*',num2str(cx)]);
title(['Wavelet Decomposition -- Wavelet Type: ',wname,' , Levels: ',num2str(N)]);
 
 
function plotcoef(N,wname,coef)
% 画出各级低频、高频系数矩阵的层次结构图
% 首先建立一个名为“Wavelet Decomposition -- Wavelet Type: , Levels: ”的图像窗口
figure('Name',['Wavelet Decomposition -- Wavelet Type: ',wname,' , Levels: ',num2str(N)]);
% 图像的第1行显示低频系数，置中，左右两个subplot为空
subplot(N+1,3,2);
yt=uint8(coef{1});
[yrow,ycol]=size(yt);
imshow(yt);title( ['Approximation A',num2str(N)]);
xlabel(['Size : ',num2str(yrow),'*',num2str(ycol)]);
% 第2-(N+1)行显示各级高频系数
titllist={['Vertical Detail V'];['Horizontal Detail H'];['Diagonal Detail D']};
pn=2;   % pn 是子图的显示序号
for pr=1:N
    for pc=1:3
        subplot(N+1,3,pn+2);
        yt=[]; 
        yt=uint8(coef{pn});
        [yrow,ycol]=size(yt);
        imshow(yt);title([ titllist{pc},num2str(N-pr+1)]);
        xlabel(['Size : ',num2str(yrow),'*',num2str(ycol)]);
        % 每行的第一个图像的Y轴，显示该行高频系数对应的分解级别
        if mod(pn+2,3)==1
            ylabel(['Level ',num2str(N-pr+1)]);
        end
        pn=pn+1;
    end
end
 
 
function [o2sa,f1sa,rsx]=sizcoef(sx,lf,N)
% 函数 sizcoef 计算小波分解的卷积过程中各分解级的矩阵大小
% 输入参数：sx —— 原始（图像）矩阵的大小
%          lf —— 滤波器的长度
%          N —— 分解级数
% 输出参数：o2sa —— 根据公式 sigLen+filLen-1 得到的卷积后矩阵大小
%          f1sa —— 经过下抽样后本级分解系数矩阵的大小
%          rsx —— 通过 f1sa 求出对应于原始矩阵的有效区域大小
% Copyright by Zou Yuhua ( chenyusiyuan ), Version: 1.0, Date: 2008-07-07
 
o2sa=sx;
f1sa=[0 0];
osx=sx;
for i=1:N
    ot=osx+lf-1;
    sa=floor(ot/2);
    o2sa=[o2sa;ot];
    f1sa=[f1sa;sa];
    osx=sa;
end
 
rsx=zeros(N+1,2);
rsx(1,:)=sx;
addln=0;
for j=2:N+1                     % 在每级卷积后，序列的长度会增长 floor(lf-1/2)，
    aln=floor((addln+lf-1)/2); % 据此可由卷积后的序列长度求出原来的输入序列长度
    tsx=f1sa(j,:)-aln;
    rsx(j,:)=tsx;
    addln=aln;
end
 
function [cA,cV,cH,cD]=mydwt2(x,Lo_D,Hi_D)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 函数 MYDWT2() 对输入的r*c维矩阵 x 进行二维小波分解，输出四个分解系数子矩阵[LL,HL,LH,HH]
% 输入参数：x —— 输入矩阵，为r*c维矩阵。
%          Lo_D,Hi_D —— 小波分解的滤波器组系数向量
% 输出参数：cA,cV,cH,cD —— 是小波分解系数矩阵的四个相等大小的子矩阵
%               cA：低频部分分解系数；    cV：垂直方向分解系数；
%               cH：水平方向分解系数；    cD：对角线方向分解系数。
%
% Copyright by Zou Yuhua ( chenyusiyuan ), Version: 3.0, Date: 2008-07-07
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 
[row,col]=size(x);                      % 读取输入矩阵的大小
for j=1:row                             % 首先对输入矩阵的每一行序列进行一维离散小波分解
    tmp1=x(j,:);
    [ca1,cd1]=mydwt(tmp1,Lo_D,Hi_D,1); 
    % tmp1 长度为 row ，滤波器长度为 lf 
    % 则 [ca1,cd1] 的总长为 2*floor(( row + lf -1 )/2)
    x1(j,:)=[ca1,cd1];                   % 将分解系数序列存入缓存矩阵 x1 中
 
end
 
 
[row1,col1]=size(x1);       % row1=row + lnf -1, col1=col+lnf-1
for k=1:col1                             % 再对缓存矩阵 x1 的每一列序列进行一维离散小波分解
    tmp2=x1(:,k);
    [ca2,cd2]=mydwt(tmp2,Lo_D,Hi_D,1);    
    x2(:,k)=[ca2,cd2]';                   % 将分解所得系数存入缓存矩阵 x2 中
    % 注意不要遗漏了上一行代码中的转置符号“ ’”。 Matlab 6.5 及以下较低的版本不支
    % 持行、列向量的相互赋值，故要把行向量[ca2,cd2]转置为列向量，再存入 x2 的相应列
 
end
 
 
[row2,col2]=size(x2);
cA=x2(1:row2/2,1:col2/2);                  % cA是矩阵x2的左上角部分
cV=x2(1:row2/2,col2/2+1:col2);              % cV是矩阵x2的右上角部分
cH=x2(row2/2+1:row2,1:col2/2);              % cH是矩阵x2的左下角部分
cD=x2(row2/2+1:row2,col2/2+1:col2);          % cD是矩阵x2的右下角部分
 
 
function [cA,cD] = mydwt(x,lpd,hpd,dim)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 函数 [cA,cD]=MYDWT(X,LPD,HPD,DIM) 对输入序列x进行一维离散小波分解，输出分解序列[cA,cD]
% 输入参数：x——输入序列；
%          lpd——低通滤波器；
%          hpd——高通滤波器；
%          dim——小波分解层数。
% 输出参数：cA——平均部分的小波分解系数；
%           cD——细节部分的小波分解系数。
%
% Copyright by Zou Yuhua ( chenyusiyuan ), Version: 1.0, Date: 2007-11-10
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 
cA=x;       % 初始化cA，cD
cD=[];
for i=1:dim
    cvl=conv(cA,lpd);   % 低通滤波，为了提高运行速度，调用MATLAB提供的卷积函数conv()
    dnl=downspl(cvl);   % 通过下抽样求出平均部分的分解系数
    cvh=conv(cA,hpd);   % 高通滤波
    dnh=downspl(cvh);   % 通过下抽样求出本层分解后的细节部分系数
    cA=dnl;                  % 下抽样后的平均部分系数进入下一层分解
    cD=[cD,dnh];         % 将本层分解所得的细节部分系数存入序列cD
end
 
 
function y=downspl(x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 函数 Y=DOWMSPL(X) 对输入序列进行下抽样，输出序列 Y。
% 下抽样是对输入序列取其偶数位，舍弃奇数位。例如 x=[x1,x2,x3,x4,x5]，则 y=[x2,x4].
%
% Copyright by Zou Yuhua ( chenyusiyuan ), Version: 1.0, Date: 2007-11-10
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 
N=length(x);         % 读取输入序列长度
M=floor(N/2);        % 输出序列的长度是输入序列长度的一半（带小数时取整数部分）
i=1:M;
y(i)=x(2*i);

