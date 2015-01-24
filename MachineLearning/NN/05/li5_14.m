 clear all;
%定义输入向量和目标向量
P=[0 1 0 1;1 0 1 0;0 0 1 1;1 1 0 0]';
T=[1 1 0 0;0 0 1 1];
%创建LVQ网络
net=newlvq(minmax(P),4,[0.5 0.5],0.01,'learnlv1');
%训练LVQ网络
net=train(net,P,T);
%网络仿真
y=sim(net,P)
