 clear all;
P=[-0.5 -0.6 0.7;0.8 0 0.1];
T=[1 1 0];
net=newp([-1 1;-1 1],1);              %建立感知器网络
%返回画线的句柄，下一次绘制分类线时将旧的删除
handle=plotpc(net.iw{1},net.b{1});
%设置训练次数最大为10次
net.trainParam.epochs=10;
net=train(net,P,T);
Q=[0.6 0.9 -0.1;-0.1 -0.5 0.5];
Y=sim(net,Q);
%绘制分类线
plotpv(Q,Y);
plotpc(net.iw{1},net.b{1})
