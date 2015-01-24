 clear all;
%输入两个期望向量T
T = [+1 +1; -1 +1; -1 -1];
%在三维空间绘制出这两个稳定平衡点
axis([-1 1 -1 1 -1 1])
set(gca,'box','on'); axis manual; 
hold on;
plot3(T(1,:),T(2,:),T(3,:),'ro')           %效果如图4-14所示
xlabel('a(1)');
ylabel('a(2)');
zlabel('a(3)');
view([37.5 30]);
%设计网络并对网络进行测试
net = newhop(T);                 %设置Hopfiled网络
a = {rands(3,1)};
[y,Pf,Af] = net({1 10},{},a);   %网络测试
%绘制出初始点向平衡点的逼近过程
record = [cell2mat(a) cell2mat(y)];
start = cell2mat(a);
hold on
plot3(start(1,1),start(2,1),start(3,1),'bp',record(1,:),record(2,:),record(3,:)) %效果如图4-15
%再随机选取25个初始点进行测试
color = 'rgbmy';
for i=1:25
   a = {rands(3,1)};
   [y,Pf,Af] = net({1 10},{},a);
   record=[cell2mat(a) cell2mat(y)];
   start=cell2mat(a);
   plot3(start(1,1),start(2,1),start(3,1),'kp', ...          %效果如图4-16所示
      record(1,:),record(2,:),record(3,:),color(rem(i,5)+1))
end
%再选取一些点，这些点都恰恰位于两个平衡点正中的位置上，并绘制这些点走向
P = [ 1.0  -1.0  -0.5  1.00  1.00  0.0; ...
      0.0   0.0   0.0  0.00  0.00 -0.0; ...
     -1.0   1.0   0.5 -1.01 -1.00  0.0];
cla
plot3(T(1,:),T(2,:),T(3,:),'ro')
color = 'rgbmy';
for i=1:6
   a = {P(:,i)};
   [y,Pf,Af] = net({1 10},{},a);
   record=[cell2mat(a) cell2mat(y)];
   start=cell2mat(a);
   plot3(start(1,1),start(2,1),start(3,1),'gp', ...            %效果如图4-17所示
      record(1,:),record(2,:),record(3,:),color(rem(i,5)+1))
end
