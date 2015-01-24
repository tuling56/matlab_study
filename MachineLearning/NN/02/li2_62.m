 clear all;
T = [-1 -1 1; 1 -1 1]';
net = newhop(T);              %创建一个Hopfield网络
Ai = T;
[Y,Pf,Af] = sim(net,2,[],Ai);
disp('显示Hopfield网络仿真：')
Y
disp('Hopfield网络权值：')
W= net.LW{1,1}
disp('Hopfield网络阈值：')
b = net.b{1,1}

