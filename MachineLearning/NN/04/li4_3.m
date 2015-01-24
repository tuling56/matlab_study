 clear all;
%具有两个稳定平衡点，其期望值为T
T = [+1 -1; -1 +1];
%在二维平面内绘制这两个稳定平衡点
plot(T(1,:),T(2,:),'mp')                %效果如图4-11所示
axis([-1.1 1.1 -1.1 1.1])
xlabel('a(1)');
ylabel('a(2)');
%设计网络，满足期望值T要求
net = newhop(T);
a = {rands(2,1)};
[y,Pf,Af] = net({1 50},{},a);
%绘制初始点向平衡点的逼近过程
record = [cell2mat(a) cell2mat(y)];      %效果如图4-12所示
start = cell2mat(a);
hold on
plot(start(1,1),start(2,1),'bx',record(1,:),record(2,:))
%另选取5个初始点来说明伪平衡点情况，这5个点在向量空间恰恰位于两个期望稳%定点正中的位置上
plot(0,0,'ko');
P = [-1.0 -0.5 0.0 +0.5 +1.0;
     -1.0 -0.5 0.0 +0.5 +1.0];
color = 'rgbmy';
for i=1:5
   a = {P(:,i)};
   [y,Pf,Af] = net({1 50},{},a);
   record=[cell2mat(a) cell2mat(y)];
   start = cell2mat(a);
   plot(start(1,1),start(2,1),'kx',record(1,:),record(2,:),color(rem(i,5)+1))  %效果如图4-13
   drawnow
end
