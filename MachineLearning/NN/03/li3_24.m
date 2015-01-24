clear all;
P=[-1 -1 2 2;0 5 0 5];
T=[-1 -1 1 1];
net=newff(minmax(P),[3,1],{'tansig','purelin'},'traincgf');
net.trainParam.show=5;
net.trainParam.epochs=300;
net.trainParam.goal=1e-5;
[net,tr]=train(net,P,T);
%对网络进行仿真
a=sim(net,P)
