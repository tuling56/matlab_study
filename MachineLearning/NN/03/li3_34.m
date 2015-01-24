 clear all;
P=-1:0.05:1;
T=exp(-P);
plot(P,T);          %效果如图3-109所示
xlabel('x');ylabel('y');
%网络创建与训练
figure;             %效果如图3-110所示
for i=1:5
    net=newgrnn(P,T,i/10);         %GRNN网络建立
    y(i,:)=sim(net,P);             %GRNN网络仿真
end
%绘制网络的逼近效果
plot(P,T);
hold on;
plot(P,y(1,:),'rp');
hold on;
plot(P,y(2,:),'d');
hold on;
plot(P,y(3,:),':');
hold on;
plot(P,y(4,:),'m-.');
hold on;
plot(P,y(5,:),'g+');
hold off;
legend('spread=0.1时网络逼近','spread=0.2时网络逼近',...
'spread=0.3时网络逼近','spread=0.4时网络逼近','spread=0.5时网络逼近')
%绘制网络的最佳逼近误差
figure;plot(P,y(1,:)-T,'ro')             %效果如图3-111所示
