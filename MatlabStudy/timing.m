% matlab计算程序运行时间的三种方法
clear all;close all; clc
%% 1，tic toc
   %程序遇到tic时Matlab自动开始计时，运行到toc时自动计算此时与最近一次tic之间的时间
tic;%tic1
t1=clock;
for i=1:3
    tic ;%tic2
    t2=clock;
    pause(3*rand)
    %计算到上一次遇到tic的时间，换句话说就是每次循环的时间
    disp(['toc计算第',num2str(i),'次循环运行时间：',num2str(toc)]);
    %计算每次循环的时间
    disp(['etime计算第',num2str(i),'次循环运行时 间：',num2str(etime(clock,t2))]);
    %计算程序总共的运行时间
    disp(['etime计算程序从开始到现在运行的时间:',num2str(etime(clock,t1))]);
    disp('======================================')
end
%计算此时到tic2的时间，由于最后一次遇到tic是在for循环的i=3时，所以计算的是最后一次循环的时间
disp(['toc计算最后一次循环运行时间',num2str(toc)])
disp(['etime程序总运行时间：',num2str(etime(clock,t1))]);
%% 2 etime(t1,t2）配合clock使用
 %通过调用windows系统的时钟进行时间差计算得到运行时间的
 t1=clock;
 %......
 t2=clock;
 etime(t2,t1)
 %% 3 cputime函数
 %使用CPU的主频计算和前面的原理不同
 t0=cputime;
 %.....
 t1=cputime-t0;
