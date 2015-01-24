clear;
Fs=80;
fp=0.6*Fs/2;
rp=0.01;
fs=0.7*Fs/2;
rs=0.1;
f= [fp fs];%通带和阻带截止频率
A=[1 0];
dev=[rp rs];
[n,f0,m0,W]=remezord(f,A,dev,Fs);%
b=remez(n,f0,m0,W);
[h,w]=freqz(b,1,256,1);
h=abs(h);h=20*log10(h);
plot(w,h);
grid;
xlabel('频率(归一化)');
ylabel('幅度(dB)');