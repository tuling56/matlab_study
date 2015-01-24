%三组二维输入向量P，以及其相对应的三个类别（期望类别）Tc
clear all;
P=[1 2;2 2;1 1]';
Tc=[1 2 3];
plot(P(1,:),P(2,:),'r.','markersize',30)             %效果如图3-113所示
for i=1:3
    text(P(1,i)+0.1,P(2,i),sprintf('class % g',Tc(i)));
end
axis([0 3 0 3])
xlabel('P(1,:)')
ylabel('P(2,:)')
%将期望类别指针Tc转换为向量T，进行网络设计
T=ind2vec(Tc);
spread=1;
net=newpnn(P,T,spread);
%对输入向量进行仿真，并将网络输出向量转换为指针
A=sim(net,P);
Ac=vec2ind(A);
%通过网络仿真得到向量的分类结果
plot(P(1,:),P(2,:),'r.','markersize',30)        %效果如图3-114所示
axis([0 3 0 3])
for i=1:3
    text(P(1,i)+0.1,P(2,i),sprintf('class % g',Ac(i)));
end
xlabel('P(1,:)')
ylabel('P(2,:)')
%再对新输入向量p进行测试
p=[2;1.5];
a=sim(net,p);
ac=vec2ind(a);
hold on
plot(p(1),p(2),'*','markersize',10,'color',[1 0 0])      %效果如图3-115所示
text(p(1)+0.1,p(2),sprintf('class % g',ac))
hold off
xlabel('p(1,:) 与p(1)')
ylabel('p(2,:) 与p(2)')
%通过立体图显示三3个类别所在面的情况，及新的输入向量对应的类别
p1=0:.05:3;
p2=p1;
[p1,p2]=meshgrid(p1,p2);
pp=[p1(:),p2(:)]';
aa=sim(net,pp);
aa=full(aa);
m=mesh(p1,p2,reshape(aa(1,:),length(p1),length(p2)));
set(m,'facecolor',[0 0.5 1],'linestyle','none');
hold on
m=mesh(p1,p2,reshape(aa(2,:),length(p1),length(p2)));
set(m,'facecolor',[0 0.1 0.5],'linestyle','none');
m=mesh(p1,p2,reshape(aa(3,:),length(p1),length(p2)));
set(m,'facecolor',[0.5 0 1],'linestyle','none');
plot3(p(1,:),p(2,:),[1 1 1]+0.1,'.','markersize',30)
plot3(p(1),p(2),1.1,'*','markersize',10,'color',[1 0 0])      %效果如图3-116所示
hold off
view(2)
xlabel('p(1,:) 与p(1)')
ylabel('p(2,:) 与p(2)')
set(gcf,'color','w')
