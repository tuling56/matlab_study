 clear all;
net = newp([0 1;-2 2],1);   %生成一个神经网络
net.inputweights{1,1}.initFcn='rands';
net.biases{1}.initFcn='rands';
net=init(net);
%检验权值与阈值
w=net.iw{1,1}
b=net.b{1}
