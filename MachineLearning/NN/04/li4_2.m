%创建一个层反馈网络
net=newnarx([-1 1],0,1,1,{'purelin'}); %创建单层、单神经元、输出延迟为1的反馈网络
net.biasConnect=0;                        %偏置值为0
net.lw{1}=0.5;                            %输出层权重为0.5
net.iw{1}=1;                              %输入层权重为1
a=sim(net,P);                 %网络再一次仿真
c=cell2mat(a); 
stem(c)                   %绘制层反馈网络序列图，效果如图4-4所示
axis([0 12 -0.5 2.5]);
%创建网络及测试
net = newhop(T);              %设计Hopfield网络
[Y,Pf,Af] = net([],[],T);         %网络测试
%再随机选取初始点，对网络进行仿真
a = {rands(2,1)};
[y,Pf,Af] = net({20},{},a);
%绘制初始点向平衡点逼近过程
record = [cell2mat(a) cell2mat(y)];
start = cell2mat(a);
hold on
plot(start(1,1),start(2,1),'bx',record(1,:),record(2,:))   %效果如图4-10所示

%再随机选取25个初始点进行测试
color = 'rgbmy';
for i=1:25
   a = {rands(2,1)};
   [y,Pf,Af] = net({20},{},a);
   record=[cell2mat(a) cell2mat(y)];
   start=cell2mat(a);
   plot(start(1,1),start(2,1),'kx',record(1,:),record(2,:),color(rem(i,5)+1))
end
