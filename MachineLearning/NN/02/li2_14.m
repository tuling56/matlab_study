clear all;
net = newlin([-1 1; -1 1],1);     %��������������
disp('��ʾ����������Ȩֵ��');
W=net.iw{1,1}
disp('��ʾ������������ֵֵ��');
b=net.b{1}
%�ı������Ȩֵ����ֵ
net.iw{1,1}=[3,5];
net.b{1}=[-2];
disp('��ʾ��ֵ��Ȩֵ��')
W=net.iw{1,1}
disp('��ʾ��ֵ�����ֵ��')
b=net.b{1}
%����������P���з��棬�������Ӧ�ĺ������a
p = [5; 6];
disp('�������ֵ��')
a = sim(net,p)