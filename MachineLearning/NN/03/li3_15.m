>> clear all;
%信号的输入
time1=0:0.05:4;
time2=4.05:0.05:6;
time=[time1 time2];
X=sin(sin(time).*time*10);
plot(time,X)                   %效果如图3-42所示
xlabel('时间');
ylabel('输入信号');
%系统输出信号
figure;
steps1=length(time1);
[T1,state]=filter([1 -0.5],1,X(1:steps1));
steps2=length(time2);
T2=filter([0.9 -0.6],1,X((1:steps2)+steps1),state);
T=[T1 T2];
plot(time,T);                    %效果如图3-43所示
xlabel('时间');
ylabel('输出信号');
%用输入信号X当前值和前一时刻的值作为线性网络的输入向量 
T=con2seq(T);
P=con2seq(X);
%创建一个线性网络，具有两个延迟输入，设定学习速率为0.5
lr=0.5;
delays=[0 1];
net=newlin(minmax(cat(2,P{:})),1,delays,lr);
%利用adapt函数对线性网络进行训练
[net,a,e]=adapt(net,P,T);
%对网络进行测试，绘制输出网络a与系统实际输出T曲线
plot(time,cat(2,a{:}),time,cat(2,T{:}),'--')           %效果如图3-44所示
ylabel('时间');
ylabel('输出 - 目标');
legend('网络输出','系统实际输出');
%绘制输出网络a与系统实际输出T曲线之间的误差
plot(time,cat(2,e{:}),[min(time) max(time)],[0 0],':r');       %效果如图3-45所示
AXIS([0 5 -2 2])
xlabel('时间');
ylabel('误差');
