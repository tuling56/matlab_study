clc;  
clear all;  
  
M = 5; %代表每个样本的维度
N = 3; %代表样本数量，也即每列代表一个样本
  
% 生成一个M*N的随机原始矩阵  
OriginMatrix = rand( M, N );  
disp(OriginMatrix)

% 使用自带的cov函数计算相关矩阵  
CovMatrix = cov( OriginMatrix ); 
disp(CovMatrix)
 
%自己动手算协方差矩阵
MeanArray = mean( OriginMatrix ); %但是在这里计算的时候计算的是每个样本的所有维度的均值，而不是所有样本的均值
MeanMatrix = ones( M, 1 ) * MeanArray;

OriginSubMean = OriginMatrix - MeanMatrix;  % 原始矩阵每列减去每列的均值的的矩阵  
  
% 计算出相关矩阵  
if M == 1  
    CovMatrixComputed = OriginSubMean' * OriginSubMean / M;  
else  
    CovMatrixComputed = OriginSubMean' * OriginSubMean / ( M-1 );  
end  