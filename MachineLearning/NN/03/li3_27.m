clear all;
%定义输入向量及目标向量
P=[1 2;-1 1;-2 1;-4 0]';
T=[0.2 0.8 0.8 0.2];
%创建BP网络和定义训练函数及参数
net=newff([-1 1;-1 1],[5 1],{'logsig','logsig'},'traingd');
net.trainParam.goal=0.001;
net.trainParam.epochs=5000;
[net,tr]=train(net,P,T);         %网络训练
disp('网络训练后的第一层权值为：')
iw1=net.iw{1}
disp('网络训练后的第一层阈值：')
b1=net.b{1}
disp('网络训练后的第二层权值为：')
iw2=net.Lw{2}
disp('网络训练后的第二层阈值：')
b2=net.b{2}
save li3_27 net;
%通过测试样本对网络进行仿真
load li3_27 net;          %载入训练后的BP网络
p1=[1 2;-1 1;-2 1;-4 0]';    %测试输入向量
a2=sim(net,p1);              %仿真输出结果
disp('输出分类结果为：')
a2=a2>0.5                    %根据判决门限，输出分类结果
