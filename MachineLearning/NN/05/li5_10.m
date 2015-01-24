 clear all;
%首先应用rands函数随机生成500个输入数据点，形成输入向量P
P=rands(2,500);
plot(P(1,:),P(2,:),'rp')           %效果如图5-19所示
axis([-1 1 -1 1]);

xlabel('P(1)');
ylabel('P(2)')
%设计一个二维SOFM网络，其神经元层有30个神经元，代表输入向量的类别
net=newsom([0 1;0 1],[5 6]);        %创建SOFM网络
cla
plotsom(net.IW{1,1},net.layers{1}.distances)      %绘制初始权值图，如图5-20所示
axis([0 1 0 1]);
xlabel('w(i,1)');
ylabel('w(i,2)');
net.trainParam.epochs=1;
net=train(net,P);             %对网络进行训练，效果如图5-21所示
%网络测试
cla
plotsom(net.iw{1,1},net.layers{1}.distances)      %效果如图5-22所示
axis([-1 1 -1 1]);
xlabel('w(i,1)');
ylabel('w(i,2)');
%对网络进行仿真
p=[0.5;0.3];
a=sim(net,p)
