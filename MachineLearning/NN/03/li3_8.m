clear all;
P=[2 1 -2 -1;2 -2 2 1];
T=[0 1 0 1];
%利用train函数训练网络，新网络初始权值和阈值缺省为0，设置训练精度为0.1
net=newlin([-2 2;-2 2],1);
net.trainParam.goal=0.1;
[net,tr]=train(net,P,T);
disp('经过训练后的权值：')
w=net.iw{1,1}
disp('经过训练后的阈值：')
b=net.b{1}
disp('仿真验证：')
y=sim(net,P)
disp('显示计算误差：')
err=T-sim(net,P)
