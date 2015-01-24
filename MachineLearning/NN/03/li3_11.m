 clear all;
%输入向量及期望输出向量
P=[1.0 2.0 3.0;4.0 5.0 6.0];
T=[0.5 1.0 -1.0];

%寻找训练用最快速稳定的学习率，创建生成一个线性神经元，并设置训练次数
% 训练精度、显示情况等，进行训练
maxlr=maxlinlr(P,'bias');
net=newlin([0 10;0 10],1,[0],maxlr);
net.trainParam.show=50;
net.trainParam.epochs=500;
net.trainParam.goal=0.001;
[net,tr]=train(net,P,T);        %效果如图3-30所示
 %对网络进行验证
p=[1.0;4];
a=sim(net,p)
