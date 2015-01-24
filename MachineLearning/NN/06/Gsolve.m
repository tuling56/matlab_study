function G=Gsolve(a,b,d,N)
%na,nb分别为多项式A,B的阶次
na=length(a)-1;
nb=length(b)-1;
a1=a(2:na+1);
G=zeros(N-d+1);
G(1,1)=b(1);
for j=2:N-d+1
    ab=0;
    for i=1:min(j-1,na)
        ab=ab+a1(i)*G(j-i,1);
    end
    if j<=nb+1
        b1j=b(j);
    else
        b1j=0;
    end
    G(j,1)=b1j-ab;
    for i=2:j
        G(j,i)=G(j-1,i-1);
    end
end
