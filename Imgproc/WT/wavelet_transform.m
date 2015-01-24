Fs=10000;N=1024;n=0:1/Fs:1;  %Fs采样频率，N采样点数，n时序点
xn=sin(400*pi*n)+cos(600*pi*n)+4*n+0.2*randn(size(n)); %变换原函数,f1=200Hz,f2=300Hz
figure(1);
plot(n,xn); %画出原函数图形
title('Original Signal');
xlabel('Time-n'); ylabel('Amplitude-xn');%标注横纵坐标
%%  绘制FT图
y=fft(xn,N)/(N/2); %对原函数进行傅里叶变化，采样点数为N,并进行幅值的归一化处理
Y=abs(y); 
w=(0:length(Y)-1)*Fs/length(Y);%计算横轴频率，符合奈奎斯特采样定理
figure(2);
plot(w,Y);%画出FT图形
xlabel('Frequency-w'); ylabel('Amplitude-Y');
title('FT figure');
%%  绘制SIFT图
[S,F,T,P] = spectrogram(xn,1024,512,1024,10000);%对原函数进行STFT变换，采用hamming窗
figure(3);
surf(T,F,10*log10(P),'edgecolor','none'); %绘出3D时频图并填充
axis tight;set(gca,'YLim',[0 5000]);%设置坐标轴
colorbar;%显示颜色条
xlabel('Time (Seconds)'); ylabel('Frequence(Hz)');zlabel('STFT');
title('STFT figure')
%% 绘出Haar小波和原信号经Harr小波变换后的图
i=20;wav='haar';
[phi,g1,xval]=wavefun(wav,i);
figure(4);subplot(1,2,1);
plot(xval,g1,'-r','LineWidth',1.5); 
xlabel('t');title('haar 时域图'); 
g2=fft(g1);g3=abs(g2);subplot(1,2,2);plot(g3); 
xlabel('f');title('haar 频域图')
figure(5);
c=cwt(xn,1:512,'haar','plot');%计算一维连续小波变换，并绘图，小波采用haar函数
title('WT figure');
colorbar;%显示颜色条
%% 绘制Hamming的时频图
figure(6);
B=ceil(8/0.15); 
p=hamming(B);%产生长度为B的Hamming窗
subplot(1,2,1);plot(p);%绘图
title('Hamming 时域图');xlabel('t'); 
[h1,h2]=freqz(p,1); 
subplot(1,2,2);
plot(h2/pi,20*log(abs(h1)/abs(h1(1))));  %画Hamming窗频谱图
title('Hamming 频域图');xlabel('f');
