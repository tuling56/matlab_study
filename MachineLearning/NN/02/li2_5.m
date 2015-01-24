clear all;
%定义输入向量及目标函数
P = [ -0.5 -0.5 +0.3 -0.1 -0.8; ...
      -0.5 +0.5 -0.5 +1.0 +0.0 ];
T = [1 1 0 0 0];
plotpv(P,T);             %绘制样本点
net = newp([-40 1;-1 50],1); %创建感知器神经网络
hold on
linehandle=plotpc(net.IW{1},net.b{1});  %返回分界线句柄
net.adaptParam.passes = 3;
linehandle=plotpc(net.IW{1},net.b{1});
for a = 1:25
   [net,Y,E] = adapt(net,P,T);
   linehandle = plotpc(net.IW{1},net.b{1},linehandle);  
drawnow;
end;
