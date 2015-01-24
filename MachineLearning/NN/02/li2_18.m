clear all;
P = [1 2 -4 7; 0.1 3 10 6];
disp('不带阈值速率为：')
lr1 = maxlinlr(P)
disp('带阈值速率为：')
lr2 = maxlinlr(P,'bias')
