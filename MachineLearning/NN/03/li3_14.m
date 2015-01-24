 clear all;
%信号的输入
time=0:0.25:5;
X=sin(sin(time).*time*10);
plot(time,X)                %效果如图3-38所示
xlabel('时间');
ylabel('输入信号');
%网络输入是输入信号X当前值和前两次的值
Q=size(X,2);
P=zeros(3,Q);
P(1,1:Q)=X(1,1:Q);
P(2,2:Q)=X(1,1:(Q-1));
P(3,3:Q)=X(1,1:(Q-2));
%如果系统输出可测，则系统输出的测量可由下列语句得到
T=filter([1 0.5 -1.5],1,X);
plot(time,T)                  %效果如图3-39所示
xlabel('时间');
ylabel('输出信号');
%生成线性网络
net=newlind(P,T);
%网络仿真
a=sim(net,P);
plot(time,a,time,T,'rp')                 %效果如图3-40所示
xlabel('时间');
ylabel('输出 - 目标');
legend('网络输出','实际输出');
