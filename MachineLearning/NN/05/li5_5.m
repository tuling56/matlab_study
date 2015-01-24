clear all;
%二维输入向量
p = [.1 .8 .1 .9; .2 .9 .1 .8];
net = newc([0 1; 0 1],2);           %构建竞争网络
net.trainParam.epochs=500
net.train(net,p);
