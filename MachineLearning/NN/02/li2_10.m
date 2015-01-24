clear all; 
err_goal=0.0015;        %设置期望误差最小值
max_epoch=9999;         %设置训练的最大次数
X=[0 1 0 1;0 1 1 0];    %样本数据
T=[0 1 1 1];            %目标数据
net=newp([0 1;0 1],1);  %创建感知器神经网络
net=init(net);          %初始化
W=rand(1,2);
b=rand;
net.iw{1,1}=W;
net.b{1}=b;
for epoch=1:max_epoch
    y=sim(net,X);
    E=T-y;
    sse=mae(E);            %计算网络权值修正后的平均绝对误差
    if(sse<err_goal)
        break;
    end
    dW=learnp(W,X,[],[],[],[],E,[],[],[],[],[]);      %调整输出层加权系数和偏值
    db=learnp(b,ones(1,4),[],[],[],[],E,[],[],[],[],[]);
    W=W+dW;
    b=b+db;
    net.iw{1,1}=W;
    net.b{1}=b;
end
epoch,W,y
