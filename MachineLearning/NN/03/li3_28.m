clear all;
%将要逼近的非线性函数设为正弦函数，其频率参数 可以调节
k=1;
p=[-1:.05:1];
t=sin(k*pi*p);
%假设频率参数为1，绘制此函数的曲线
plot(p,t,':')                  %效果如图3-66
xlabel('时间');
ylabel('非线性函数');
 %建立网络
n=10;
net=newff(minmax(p),[n,1],{'tansig','purelin'},'trainlm');
y1=sim(net,p);          %网络仿真
figure;
plot(p,t,'r:',p,y1,'-')               %效果如图3-67所示    
xlabel('时间');
ylabel('仿真输出--  原函数-')
legend('原函数曲线','BP网络输出曲线')
%网络训练参数设置及训练
net.trainParam.epochs=50;
net.trainParam.goal=0.01;
net=train(net,p,t);                %效果如图3-68所示
 %网络测试
y2=sim(net,p);
figure;
plot(p,t,'-',p,y1,'--',p,y2,'+')           %效果如图3-69所示
xlabel('时间');
ylabel('仿真输出')
legend('原曲线','BP网络输出曲线','训练后曲线');
