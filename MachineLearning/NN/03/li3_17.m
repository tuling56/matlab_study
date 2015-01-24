clear all;
% 定义输入向量和目标向量
time=0.01:0.01:10;           %时间变量
noise=(rand(1,1000)-0.5)*4;   %随机噪声
input=sin(time);             %信号
p=noise;                   %将噪声作为ADALINE的输入向量
t=input+noise;              %将噪声+信号作为目标向量
% 创建线性神经网络
net=newlin([-1 1],1,0,0.0005);
% 线性神经网络的自适应调整(训练)
net.adaptParam.passes=70;
[net,y,output]=adapt(net,p,t);  %输出信号output为网络调整过程中的误差
%绘制信号,迭加随机噪声的信号,输出信号的波形
hold on;
% 绘制信号的波形
subplot(3,1,1);plot(time,input,'r');
title('信号波形 sin(t)');
subplot(3,1,2);plot(time,t,'m'); %绘制迭加随机噪声信号的波形
xlabel('t');title('随机噪声波形 sin(t)+noise(t)');
% 绘制输出信号的波形
subplot(3,1,3);plot(time,output,'b');
xlabel('t');title('输出信号波形 y(t)');
