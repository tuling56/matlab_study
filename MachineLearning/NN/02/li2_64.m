 clear all;
P = [-3 -2 -2 0 0 0 0 2 2 3; 0 1 -1 2 1 -1 -2 1 -1 0];        %样本数据
Tc = [1 1 1 2 2 2 2 1 1 1];                                   %目标数据
T = ind2vec(Tc);                                             
targets = full(T)                                   %用满矩阵表示
net = newlvq(P,4,[.6 .4]);                          %创建LVQ网络
disp('LVQ网络第一层权值：')
net.IW{1,1}
disp('LVQ网络第二层权值：')
net.LW{2,1}
disp('LVQ网络仿真值：')
Y = sim(net,P)                 %网络仿真
