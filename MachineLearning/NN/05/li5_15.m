clear all;
%二维输入向量 ，以及其相应所属的类别 ，
P=[-3 -2 -2 0 0 0 0 +2 +2 +3;0 +1 -1 +2 +1 -1 -2 +1 -1 0];
C=[1 1 1 2 2 2 2 1 1 1];
T=ind2vec(C);          %将C转换成向量形式T
%绘制出输入数据点
i=1;
cla
for i=1:10
    if C(i)==1
        plot(P(1,i),P(2,i),'+')          %效果如图5-41所示
        hold on
    else
        plot(P(1,i),P(2,i),'o')
        hold on
    end
end
xlabel('P(1)');
ylabel('P(2)');
%用newlwq函数构建一个LVQ网络。
net=newlvq(minmax(P),4,[.6 .4],0.1);
%绘制初始网络竞争神经元的权值向量
hold on
W1=net.iw{1};
plot(W1(1,1),W1(1,2),'r*');          %效果如图5-42所示
xlabel('P(1),W(1)');
ylabel('P(2),W(2)');
%设置网络训练参数，应用train函数对前面所构建的网络加以训练。
net.trainParam.epochs=150;
net.trainParam.show=Inf;
net=train(net,P,T);              %效果如图5-43所示
%将输入向量和训练后的网络权值向量绘制在一张图上
cla;
plotvec(P,C);
hold on;
plotvec(net.IW{1}',vec2ind(net.LW{2}),'o');       %效果如图5-44所示
xlabel('P(1),W(1)');
ylabel('P(2),W(2)')
p=[0.2;1];
a=vec2ind(sim(net,p))
