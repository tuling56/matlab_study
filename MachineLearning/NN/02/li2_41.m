clear all;
net = newsom([0 2; 0 1],[2 3]);                 %创建一个自组织特征映射网络
P = [.1 .3 1.2 1.1 1.8 1.7 .1 .3 1.2 1.1 1.8 1.7;...    %分类数目
0.2 0.1 0.3 0.1 0.3 0.2 1.8 1.8 1.9 1.9 1.7 1.8];
plot(P(1,:),P(2,:),'.g','markersize',20)             %标记分类
hold on
plotsom(net.iw{1,1},net.layers{1}.distances)     %特征网络与分类点距离
hold off
