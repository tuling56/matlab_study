function y=myidwt2(LL,HL,LH,HH)
% 函数 MYIDWT2() 对输入的子矩阵序列进行逆小波变换，重构出矩阵 y
% 输入参数：LL,HL,LH,HH —— 是四个大小均为 r*c 维的矩阵
% 输出参数：y —— 是一个大小为 2r*2c 维的矩阵

lpr=[1 1];hpr=[1 -1];           % 默认的低通、高通滤波器
tmp_mat=[LL,HL;LH,HH];          % 将输入的四个矩阵组合为一个矩阵
[row,col]=size(tmp_mat);        % 求出组合矩阵的行列数

for k=1:col                     % 首先对组合矩阵tmp_mat的每一列，分开成上下两半
    ca1=tmp_mat(1:row/2,k);     % 分开的两部分分别作为平均系数序列ca1、细节系数序列cd1
    cd1=tmp_mat(row/2+1:row,k);
    tmp1=myidwt(ca1,cd1,lpr,hpr);   % 重构序列
    yt(:,k)=tmp1;                % 将重构序列存入待输出矩阵 yt 的相应列，此时 y=[L|H]
end

for j=1:row                     % 将输出矩阵 y 的每一行，分开成左右两半
    ca2=yt(j,1:col/2);           % 分开的两部分分别作为平均系数序列ca2、细节系数序列cd2
    cd2=yt(j,col/2+1:col);
    tmp2=myidwt(ca2,cd2,lpr,hpr);   % 重构序列
    yt(j,:)=tmp2;                % 将重构序列存入待输出矩阵 yt 的相应行，得到最终的输出矩阵 y=yt
end
y=yt;