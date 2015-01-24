 clear all;
%输入向量和期望输出
P=[-0.5 -0.5 +0.3 -0.1 -40;-0.5 +0.5 -0.5 +1.0 50];
T=[1 1 0 0 1];
plotpv(P,T);            %效果如图3-16所示
%构建向量和初始网络
net=newp([-40 1;-1 50],1);
hold on
linehandle=plotpc(net.iw{1},net.b{1});    
%应用初始网络无法分类，因此无法画出分类线
%网络修正
E=1;
net.adaptParam.passes=3;
while (sse(E))
    [net,Y,E]=adapt(net,P,T);
    linehandle=plotpc(net.IW{1},net.b{1},linehandle);  %效果如图3-17所示
    drawnow;
end
%可以用一组新的输入量来验证网络的性能
p=[0.7;1.2];
a=sim(net,p);
plotpv(P,T);
plotpc(net.IW{1},net.b{1});           %效果如图3-18所示
hold off;
>> %为了使图形清晰，修改坐标值放大部分图形
axis([-2 2 -2 2]);                    %效果如图3-19所示
