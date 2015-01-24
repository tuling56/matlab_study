clear all;
x=-1:0.1:1;        %给定要逼近的函数样本数据
T=cos(x*pi);       
n=-3:.1:3;         %径向基传输函数
a1=radbas(n);      %径向基加权和
a2=radbas(n-1.2);a3=radbas(n+2);
a=a1+1.2*a2+0.6*a3;
plot(n,a1,'+',n,a2,':',n,a3,n,a,'p');
legend('径向基加权和a1','径向基加权和a2','径向基加权和a3','径向基加权和a');
net=newrb(x,T,0.025,1);       %建立径向基网络
x1=-1:.01:1;
y=sim(net,x1);      %网络仿真
figure;plot(x1,y,x,T,'o');     
legend('函数逼近曲线','原曲线');
