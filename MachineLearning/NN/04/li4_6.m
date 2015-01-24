clear all;
%定义输入向量和目标向量
Time1=0:0.05:1.5*pi;
T1=Time1/(1.5*pi)-0.5;
Time2=1.5*pi:0.05:3*pi;
T2=1.5-Time2/(1.5*pi);
Time=[Time1 Time2];
%三角波（目标向量）
T=2*[T1 T2];
%调幅波（输入向量）
p=(1+T).*cos(20*Time);
%创建Elman网络
net=newelm(minmax(p),[20 1],{'tansig','purelin'},'traingdx');
%训练Elman网络
Pq=con2seq(p);    %将输入向量矩阵转换为输入序列
Tq=con2seq(T);    %将目标向量矩阵转换为目标序列
plot(Time,p,Time,1+T,'r--');
pause;
net.trainParam.epochs=500;
[net,tr]=train(net,Pq, Tq);
%选用了三角波、正弦波和矩形波3种调制信号形成的已调波形作为测试信号，
%对所设计的Elman神经网络进行仿真，其仿真程序如下：
%以三角波调制进行仿真
Time1=0:0.05:2*pi;
T1=Time1/(2*pi)-0.5;
Time2=2*pi:0.05:4*pi;
T2=1.5-Time2/(2*pi);
Time=[Time1 Time2];
%三角波（目标向量）
T=[T1 T2];
%调幅波（输入向量）
p=(1+T).*cos(20*Time);  %形成三角波调制的已调波信号
subplot(321);
plot(Time,p);
Pq=con2seq(p);
A=sim(net,Pq);
Y=seq2con(A);
subplot(322);
plot(Time,Y{1},Time,T,'r--');
%以正弦波调制进行仿真
T=0.5*sin(Time);
p=(1+T).*cos(20*Time);
subplot(323);
plot(Time,p);
Pq=con2seq(p);
A=sim(net,Pq);
Y=seq2con(A);
subplot(324);
plot(Time,Y{1},Time,T,'r--');
%以矩形波调制进行仿真
T=0.5*sign(sin(Time));
p=(1+T).*cos(20*Time);
subplot(325);
plot(Time,p);
Pq=con2seq(p);
A=sim(net,Pq);
Y=seq2con(A);
subplot(326);
plot(Time,Y{1},Time,T,'r--');
