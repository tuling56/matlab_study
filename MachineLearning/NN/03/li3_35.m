%�����ά��������P���Լ������Ӧ����������������Tc
clear all;
P=[1 2;2 2;1 1]';
Tc=[1 2 3];
plot(P(1,:),P(2,:),'r.','markersize',30)             %Ч����ͼ3-113��ʾ
for i=1:3
    text(P(1,i)+0.1,P(2,i),sprintf('class % g',Tc(i)));
end
axis([0 3 0 3])
xlabel('P(1,:)')
ylabel('P(2,:)')
%���������ָ��Tcת��Ϊ����T�������������
T=ind2vec(Tc);
spread=1;
net=newpnn(P,T,spread);
%�������������з��棬���������������ת��Ϊָ��
A=sim(net,P);
Ac=vec2ind(A);
%ͨ���������õ������ķ�����
plot(P(1,:),P(2,:),'r.','markersize',30)        %Ч����ͼ3-114��ʾ
axis([0 3 0 3])
for i=1:3
    text(P(1,i)+0.1,P(2,i),sprintf('class % g',Ac(i)));
end
xlabel('P(1,:)')
ylabel('P(2,:)')
%�ٶ�����������p���в���
p=[2;1.5];
a=sim(net,p);
ac=vec2ind(a);
hold on
plot(p(1),p(2),'*','markersize',10,'color',[1 0 0])      %Ч����ͼ3-115��ʾ
text(p(1)+0.1,p(2),sprintf('class % g',ac))
hold off
xlabel('p(1,:) ��p(1)')
ylabel('p(2,:) ��p(2)')
%ͨ������ͼ��ʾ��3��������������������µ�����������Ӧ�����
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
plot3(p(1),p(2),1.1,'*','markersize',10,'color',[1 0 0])      %Ч����ͼ3-116��ʾ
hold off
view(2)
xlabel('p(1,:) ��p(1)')
ylabel('p(2,:) ��p(2)')
set(gcf,'color','w')