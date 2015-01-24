function out=selfdwt(in,J)
% 完成J尺度Haar小波变换
% in 是输入信号
% out 是输出的小波系数
%h0,h1是相应的小波和尺度向量
h0=[1/sqrt(2),1/sqrt(2)]; 
h1=[-1/sqrt(2),1/sqrt(2)];
out=zeros(size(in));
m=size(in);%此处的m为一向量
x=length(in);
k=0;
l=0;
Wl=in;
for i=1:J
%=================此处对应于高频部分，结果中抽取偶数的点=====================
    Wh=conv(h1,Wl);
    for j=1:(length(h1)+length(Wl)-1)
        if mod(j,2)==0
            k=k+1;
            out(round(x/2)+k)=Wh(j);
        end
    end
 %============================================================================
 %===============下面对应于低频部分，结果中抽取偶数点=========================
    Wl1=conv(h0,Wl);
    for j=1:(length(h0)+length(Wl)-1)
        if mod(j,2)==0
            l=l+1;
            out(l)=Wl1(j);
        end
    end
  %===========================================================================
    x=round(x/2);
    m=round(m/2);
    Wl=zeros(m);
    for j=1:x
        Wl(j)=out(j);
    end
    k=0;
    l=0;
end

    
    