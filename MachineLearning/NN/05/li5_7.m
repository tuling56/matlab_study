clear all;
%定义输入向量
P=[-0.1961 0.1961 0.9806 0.9806 -0.5812 -0.8137;...
    0.9806 0.9806 0.1961 -0.1961 -0.8137 -0.5812];
net=newc([-1 1;-1 1],3);         %创建竞争型网络
net=train(net,P);               %网络训练
y=sim(net,P);                   %网络仿真
yc=vec2ind(y)                   %
%网络设计
net=newc([0 1;0 1],8,.1);
%绘制权值向量，观察初始网络进行模式识别的情况
w=net.iw{1};
hold on;
circle=plot(w(:,1),w(:,2),'ob');          %效果如图5-10所示
%对网络训练参数时行设置，并对其进行训练
net.trainParam.epochs=7;          
net=train(net,P);                 %效果如图5-11所示
%对网络进行测试
w=net.iw{1};
delete(circle);
plot(w(:,1),w(:,2),'ob');            %效果如图5-12所示
%对网络进行仿真
p=[0;0.2];
a=sim(net,p)
