clear all;
net = newff([-10 10],[4 1],{'tansig','purelin'});    %创建一个BP网络
p = [-10 -5 0 5 10];
t = [0 0 1 1 1];
y = sim(net,p);
e = t-y;
net.performParam.ratio=20/(20+1);
perf = msereg(e,net)
