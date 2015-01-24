 clear all;
net = newp([0 1;-2 2],1);   %生成一个神经网络
disp('初始化前权值为：')
w1=net.iw{1,1}                 %权值
disp('初始化前阈值为：')
b1=net.b{1}
disp('改变权值为：')
net.iw{1,1}=[5,6];
w2=net.iw{1,1}
disp('改变阈值为：')
net.b{1}=7;
b2=net.b{1}
net = init(net);           %利用网络初始化复原网络权值与阈值
disp('复原后权值为：')
w3=net.iw{1,1}
disp('复原后阈值为：')
b3=net.b{1}
