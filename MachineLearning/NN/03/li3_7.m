 clear all;
P=[1 -1.1];
T=[0.5 1];
[R,Q]=size(P);
[S,Q]=size(T);
lr=0.4*maxlinlr(P);                    % 最佳学习速率
net=newlin(minmax(P),S,[0],lr);        %创建线性网络
net.inputWeights{1,1}.initFcn='rands'; %初始化权值
net.biases{1}.initFcn='rands';         %初始化偏差
net=init(net);                         %把初始化的权值和偏差函数赋给网络
disp('显示初始化权值：')
w0=net.iw{1,1}
disp('显示初始化偏差：')
b0=net.b{1}
net.trainParam.epochs=20;              %最大循环次数
net.trainParam.goal=0.001;             %期望误差
[net,tr]=train(net,P,T);               %进行线性网络权值训练
disp('显示网络训练后最后权值：')
w=net.iw{1,1}
disp('显示网络训练后最后偏差：')
b=net.b{1}

 net=newlind(P,T);
disp('最终权值：')
w=net.iw{1,1}
disp('最终偏差：')
b=net.b{1}
%用sim函数检查所设计的网络
a=sim(net,P)
%求误差平方和
sse=sumsqr(T-a)

