 clear all; 
net = newp([-10 10],1);        %创建感知神经网络
p = [-10 -5 0 5 10];           %样本向量
t = [0 0 1 1 1];               %目标向量
y = sim(net,p)                 %网络仿真              
e = t-y                        %误差矩阵
perf = mae(e)                  %平均绝对误差
