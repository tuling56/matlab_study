clear all;
%输入向量及期望输出向量
P=[1 1.5 3 -1.2];
T=[0.5 1.1 3 -1];
%给出权值和阈值的范围并绘制误差曲线及误差曲面等高线
w_range=-2:0.4:2;
b_rang=-2:0.4:2;
ES=errsurf(P,T,w_range,b_rang,'purelin');
plotes(w_range,b_rang,ES);                     %效果如图3-31所示
%寻找训练用最快速稳定的学习率，创建生成一个线性神经元，并设置训练次数
maxlr=maxlinlr(P,'bias');
net=newlin([-2 2],1,[0],maxlr);
net.trainParam.epochs=16;
%设定训练参数，对网络进行训练，缺省的学习规则为W-H规则，
%也可以在训练参数中修改
net.trainParam.epochs=1;
net.trainParam.show=NaN;
h=plotep(net.IW{1},net.b{1},mse(T-sim(net,P))); 
[net,tr]=train(net,P,T);
r=tr;
epoch=1;
while epoch<5
    epoch=epoch+1;
    [net,tr]=train(net,P,T);                              %效果如图3-22所示
    if length(tr.epoch)>1
        h=plotep(net.IW{1,1},net.b{1},tr.perf(2),h);        %效果如图3-23所示
        r.epoch=[r.epoch epoch];
        r.perf=[r.perf tr.perf(2)];
        v.vperf=[r.vperf NaN];
        r.tperf=[r.tperf NaN];
    else
        break
    end
end
tr=r;
%训练误差没有达到0，这是由于超定系统的非线性造成的
solvednet=newlind(P,T);
hold on;
plot(solvednet.IW{1,1},solvednet.b{1},'ro')
hold off;
subplot(1,2,2);
plotperf(tr,net.trainParam.goal);             %绘制出的误差响应曲线如图3-24所示。
%对网络进行验证
p=-1.4;
a=sim(net,p)
