 clear all;
P = [1 2 3];
T = [2.0 4.1 5.9];
net = newrb(P,T);
P = 1.5;
Y = sim(net,P)
