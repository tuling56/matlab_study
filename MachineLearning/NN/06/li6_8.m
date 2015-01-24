 net.trainParam.epochs=2000;
net=train(net,p,T');
clear all;
x1=rands(400)*pi;
x2=rands(300)*pi;
x3=zeros(100,1)*pi;
p1=x1;
p2=[x2;x3];
p=[p1 p2]';
delta=0.05;
T=p2+delta*(10*sin(p1)-2*p2);
net=newff(minmax(p),[9,1],{'tansig','purelin'});         %创建神经网络
net.trainParam.epochs=2000;
net=train(net,p,T');                 %效果如图6-24所示
%利用x2=0的测试样本求网络的仿真输出
a=0:0.1:3.9;
b=zeros(1,40);
p_test=[a;b];
y=sim(net,p_test);                    %对网络进行仿真
nf=0.5*sin(a);
plot(a,y);
hold on;
plot(a,nf,'rp');
hold off;
figure;
%利用x1=pi/2的测试样本求网络的仿真输出
a=ones(1,40)*0.5*pi;
b=-10:0.5:9.5;
p_test=[a;b];
y=sim(net,p_test);
nf=0.5+0.9*b;
plot(b,y);
hold on;
plot(b,nf,'rp');
hold off;
