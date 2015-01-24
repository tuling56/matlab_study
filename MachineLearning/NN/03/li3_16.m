clear all;
% 定义输入向量和目标向量
time=0.5:0.5:20;          %时间变量
y=(rand(1,40)-0.5)*4;      %定义随机输入信号
p=con2seq(y);            %将随机输入向量转换为串行向量
delays=[1 2];             %定义ADALINE神经元输入延迟量
t=p;                     %定义ADALINE神经元的数目向量
% 创建线性神经网络
net=newlin(minmax(y),1,delays,0.0005);
% 线性神经网络的自适应调整(训练)
net.adaptParam.passes=70;
[net,a,output]=adapt(net,p,t);  %输出信号output为网络调整过程中的误差
% 绘制随机输入信号\输出信号的波形
hold on;
subplot(3,1,1);plot(time,y,'r*-'); %输出信号output为网络调整过程中的误差
xlabel('t','position',[20.5,-1.8]);
ylabel('随机输入信号s(t)');
axis([0 20 -2 2]);
subplot(3,1,2);
output=seq2con(output);
plot(time,output{1},'ko-');     %绘制预测输出信号的波形
xlabel('t','position',[20.5,-1.8]);
ylabel('预测输出信号y(t)');
axis([0 20 -2 2]);
subplot(3,1,3);
e=output{1}-y;
plot(time,e,'k-');             %绘制误差曲线
xlabel('t','position',[20.5,-1.8]);
ylabel('误差曲线e(t)');
axis([0 20 -2 2]);
hold off;
