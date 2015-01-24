clear all;
X = [0 1; 0 1];   
clusters = 8;     % 产生具有8类样本类别的样本点
points = 10;      % 在每个集群点的数目
std_dev = 0.05;   % 每个群集的标准偏差
P = nngenc(X,clusters,points,std_dev);
plot(P(1,:),P(2,:),'+r');
xlabel('p(1)');
ylabel('p(2)');
%建立神经元的8个自组织竞争神经网络，并求出初始权值
net = newc([0 1;0 1],8,.1);
w = net.IW{1};
%训练神经网络，并设置最大训练步数为7
net.trainParam.epochs = 7;
net=init(net);
net = train(net,P);
w = net.IW{1};
plot(P(1,:),P(2,:),'+r');
hold on;
circles = plot(w(:,1),w(:,2),'ob');
hold off;
P1=[0.5;0.8];
y=sim(net,P1)              %仿真网络
