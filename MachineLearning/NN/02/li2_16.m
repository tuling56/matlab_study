 clear all;
T1=0:0.24:4;
T=sin(T1*5*pi);
Q=length(T);             %生成一个信号作为预测信号
%将信号T延时1~5个时间步长得到的网络的输入X
X=zeros(5,Q);
X(1,2:Q)=T(1,1:(Q-1));
X(2,3:Q)=T(1,1:(Q-2));
X(3,4:Q)=T(1,1:(Q-3));
X(4,5:Q)=T(1,1:(Q-4));
X(5,6:Q)=T(1,1:(Q-5));
figure;plot(T1,T);         %绘制信号T的曲线
hold on;
net=newlind(X,T);         %构建一个线性层
y=sim(net,X);             %网络仿真
plot(T1,y,':',T1,T-y,'r*');
