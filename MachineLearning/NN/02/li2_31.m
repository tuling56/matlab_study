clear all;
p = [-1 -1 2 2; 0 5 0 5];
t = [-1 -1 1 1];
net = newff(p,t,3,{},'traingdm');        %创建BP网络
%对BP网络训练参数进行设置
net.trainParam.lr = 0.05;
net.trainParam.mc = 0.9;
y = sim(net,p)                           %对网络进行仿真
