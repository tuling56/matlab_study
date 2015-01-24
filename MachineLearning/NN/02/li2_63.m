clear all;
T1=1:80;             %定义输入信号及目标信号
X1=cos(1:20);
X2=3*cos(1:20);
t1=ones(1,20);
t2=3*ones(1,20);
P=[X1 X2 X1 X2];
t=[t1 t2 t1 t2];
X = con2seq(P);    %将矩阵信号转换为序列信号
T = con2seq(t);    
plot(T1,cat(2,X{:}),':',T1,cat(2,T{:}),'-');
[R,N]=size(X);
[S2,N]=size(T);
S1=10;         
net=newelm(X,T,[S1 S2],{'tansig','purelin'},'trainlm');
xlabel('t');
net.trainParam.epochs=5000;          %训练时间
[net,tr]=train(net,X,T);             %训练网络
y=sim(net,X);                       %网络仿真
hold on;
plot(T1,cat(2,y{:}),'o',T1,cat(2,T{:}),'p');
legend('输入信号曲线','目标信号曲线','输出信号曲线','目标信号曲线');
