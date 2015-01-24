 clear all;
%构造确认样本集val 
P=[-1:0.05:1];                                  %训练样本的输入向量
t0=sin(3*pi*P);                                 %待拟合的正弦函数
t=sin(3*pi*P)+0.15*randn(size(P));              %训练样本的目标向量
val.P=[-0.975:0.05:0.975];                      %确认样本的输入向量
val.T=sin(3*pi*val.P)+0.15*randn(size(val.P));  %确认样本的目标向量
%构造网络
net=newff([-1 1],[20 1],{'tansig','purelin'},'traingdx');
net.trainParam.show=25;
net.trainParam.epochs=300;
net=init(net);                                  %网络初始化
%网络训练
[net,tr]=train(net,P,t,[],[],val);
save li317 net;                                 %存储训练后


 clear all;
P=[-1:0.05:1];                                  %训练样本的输入向量
t0=sin(3*pi*P);                                 %待拟合的正弦函数
t=sin(3*pi*P)+0.15*randn(size(P));              %训练样本的目标向量
load li317 net;                                 %载入网络
r=sim(net,P);
hold on;
plot(P,t0,'r-.',P,t,'g+',P,r,'k'); 
legend('待拟合的正弦曲线','加噪的正弦曲线','网络拟合曲线');

