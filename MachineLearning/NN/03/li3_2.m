 clear all;
%线性不可分输入矢量
P=[-0.5 -0.5 0.3 0 -0.8;-0.5 0.5 -0.5 1 0];
%目标矢量
T=[1.0 1.0 0 0 0];
V=[-2 2 -2 2];
net=newp(minmax(P),1,'hardlim','learnp');      %创建一个感知器网络
net.inputweights{1,1}.initFcn='rands';         %赋输入权值的产生函数
net.biases{1}.initFcn='rands';                 %赋偏差的产生函数
net=init(net);                                 %网络初始化
disp('输出初始化权值：')
W0=net.iw{1,1}         
disp('输出初始化偏差：')                    
B0=net.b{1}
A=sim(net,P);                                  %网络仿真
net.trainParam.epochs=40;
[net,tr]=train(net,P,T);                       %训练网络权值
W=net.iw{1};
B=net.b{1};
plotpv(P,T,V);  
hold on;
plotpc(W0,B0);                                 %绘制分类线曲线
plotpc(W,B);
hold off;
fprintf('\n 最终的网络值：\n')
W
B
fprintf('最大训练次数：')
max(tr.epoch)
fprintf('\n网络分类：')
if all(hardlim(W*P+B)==T)
    disp('可分模式');
else
    disp('不可分模式');
end
