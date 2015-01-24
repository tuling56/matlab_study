 clear all;
X=[1 2;-1 2;2 3];        %输入训练集
T=[1 2;2 1];             %目标集
net=newff(X,T,5);        %建立BP网络
net=train(net,X,T);      %网络训练
X1=X; 
disp('输出网络仿真数据：')
y=sim(net,X1)
