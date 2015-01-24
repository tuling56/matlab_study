clear all;
P = [1 2 3 4 5 6 7];
Tc = [1 2 3 2 2 3 1];
T = ind2vec(Tc)               %将数据索引转换为向量组
net = newpnn(P,T);
Y = sim(net,P)
Yc = vec2ind(Y)               %将向量组转换为数据索引
