 clear all;
%输入向量及期望输出向量
P=[+1.0];
T=[+0.5];
%给出权值和阈值的范围并绘制误差曲线及误差曲面等高线
w_range=-1:0.2:1;
b_range=-1:0.2:1;
ES=errsurf(P,T,w_range,b_range,'purelin');
plotes(w_range,b_range,ES);                  %效果如图3-25所示
%寻找训练用最快速稳定的学习率，创建生成一个线性神经元，并设置训练次数
maxlr=maxlinlr(P,'bias');
net=newlin([-2 2],1,[0],maxlr);
net.trainParam.goal=1e-10;
%设定训练参数，对网络进行训练，缺省的学习规则为W-H规则，也可以在训练参数中修改
net.trainParam.epochs=1;
net.trainParam.show=NaN;
h=plotep(net.IW{1},net.b{1},mse(T-sim(net,P)));
[net,tr]=train(net,P,T);
r=tr;
epoch=1;
while true
    epoch=epoch+1;
    [net,tr]=train(net,P,T);                      %效果如图3-26所示
    if length(tr.epoch)>1
        h=plotep(net.IW{1},net.b{1},tr.perf(2),h);  %效果如图3-27所示
        r.epoch=[r.epoch epoch];
        r.perf=[r.perf tr.perf(2)];
        r.vperf=[r.vperf NaN];
        r.tperf=[r.tperf NaN];
    else
        break
    end
end
tr=r;
 solvednet=newlind(P,T);
hold on;
plot(solvednet.IW{1,1},solvednet.b{1},'ro')       %效果如图3-28所示
%绘制训练误差随时间变化的曲线，训练误差与训练精度有很大关系
hold off;
plotperf(tr,net.trainParam.goal);             %绘制出的误差响应曲线如图3-29所示。
 %对网络进行验证
p=1.0;
a=sim(net,p)
