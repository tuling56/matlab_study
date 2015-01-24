clear all;
P = [0 2];
T = [0 1];
net = newp(P,T);
%观察生成的神经网络
inputweights = net.inputweights{1,1}
 biases = net.biases{1}