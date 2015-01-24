clear all;
err_goal=0.0015;        %设置期望误差最小值
max_epoch=5000;         %设置训练的最大次数
X=[0 0 1 1;0 1 1 0];    %样本数据
T=[0 1 1 1];            %目标数据
[M,N]=size(X);
[L,N]=size(T);           %L为输出节点i的数量，N为训练集对数量
Wij=rand(L,M);          %给定随机输出层的权值
b1=zeros(L,1);          %给定随机输出层的阈值
for epoch=1:max_epoch
    net=netsum(Wij*X,b1);
    y=hardlim(net);
    E=T-y;
    sse=mae(E);            %计算网络权值修正后的平均绝对误差
    if(sse<err_goal)
        break;
    end
    Wij=Wij+E*X';
    b1=b1+E;
end
epoch,Wij
%感知器的第二阶段工作期和给定的输出计算输出
X1=X;
net=netsum(Wij*X1,b1);
y=hardlim(net)
