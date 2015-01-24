clear all;
net = newlin([-1 1; -1 1],1);     %创建线性神经网络
disp('显示线性神经网络权值：');
W=net.iw{1,1}
disp('显示线性神经网络阈值值：');
b=net.b{1}
%改变网络的权值与阈值
net.iw{1,1}=[3,5];
net.b{1}=[-2];
disp('显示赋值后权值：')
W=net.iw{1,1}
disp('显示赋值后的阈值：')
b=net.b{1}
%对输入向量P进行仿真，计算出相应的函数输出a
p = [5; 6];
disp('网络仿真值：')
a = sim(net,p)
