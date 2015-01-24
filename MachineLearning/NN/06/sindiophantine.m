function [e,f,g]=sindiophantine(a,b,c,d)
%��ⵥ��Diophantine���̺���
%na,nb,ncΪ����ʽA,B,C�״�
na=length(a)-1;
nb=length(b)-1;
nc=length(c)-1;
ne=d-1; ng=na-1;        %E,G�Ľ״�
ad=[a,zeros(1,ng+ne+1-na)];
cd=[c,zeros(1,ng+d-nc)];
e(1)=1;
for i=2:ne+1
    e(i)=0;
    for j=2:i
        e(i)=e(i)+e(i+1-j)*ad(j);
    end
    e(i)=cd(i)-e(i);        %����ei
end
for i=1:ng+1
    g(i)=0;
    for j=1:ne+1
        g(i)=g(i)+e(ne+2-j)*ad(i+j);
    end
    g(i)=cd(i+d)-g(i);      %����gi
end
f=conv(b,e);                %����F