 clear all;
%设计一个感知器，将二维的四组输入矢量分成两类
P=[-0.5 -0.5 0.3 0;-0.5 0.5 -0.5 1];
%目标矢量
T=[1.0 1.0 0 0];
net=newp(minmax(P),1);
A=sim(net,P);                 %训练前的网络输出
net.trainParam.epochs=20;     %定义最大循环次数
net=train(net,P,T);           %训练网络，使输出和期望相同
disp('输出训练后的网络权值：')
net.iw{1,1}
disp('输出训练后的网络偏差：')
net.b{1}
A=sim(net,P)                  %训练后网络的输出
