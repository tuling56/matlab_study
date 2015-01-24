 clear all;
pi=3.1416;
angles=0:0.5*pi/90:0.5*pi;
P=[sin(angles);cos(angles)];
plot(P(1,:),P(2,:),'r.');          %输入点图，输入矢量如图5-15所示
axis equal;
[R,Q]=size(P);
S=20;
W0=rands(S,R)*0.1;                %随机产生权值
hold on;
plotsom(W0')               %绘制权值点及与其相邻权值点的连线，如图5-16所示
hold off
net=newsom(minmax(P),S);          %创建SOFM网络
net.trainParam.epochs=400;        %最大训练次数
net.trainParam.show=5;
net=train(net,P);                 %训练网络，效果如图5-17所示
figure;
plot(P(1,:),P(2,:),'.g','markersize',20);  %输入点，效果如图5-18所示
hold on;
%作训练后的权值点及其相邻权值点的连线
plotsom(net.iw{1,1},net.layers{1}.distances);

