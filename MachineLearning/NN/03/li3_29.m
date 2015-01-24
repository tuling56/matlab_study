 clear all;
load choles_all;
[pn,meanp,stdp,tn,meant,stdt]=prestd(p,t);
%删除一些数据，只保留了所占99.9%的主要成分数据
[ptrans,transMat]=prepca(pn,0.001);
[R,Q]=size(ptrans)              %检查转换后数据矩阵大小
 iitst=2:4:Q;
iival=4:4:Q;
iitr=[1:4:Q 3:4:Q];
val.P=ptrans(:,iival);
val.T=tn(:,iival);
test.P=ptrans(:,iitst);
test.T=tn(:,iitst);
ptr=ptrans(:,iitr);
ttr=tn(:,iitr);
%创建网络，隐层神经元初步设计为5个，因为需要得到3个目标，
%网络输出层设计为3个神经元
net=newff(minmax(ptr),[5,3],{'tansig','purelin'},'trainlm');
%采用Levenberg-Marquardt算法对BP进行网络训练
%创建网络，隐层神经元初步设计为5个，因为需要得到3个目标，网络输出层设计为3个神经元
net=newff(minmax(ptr),[5,3],{'tansig','purelin'},'trainlm');    %效果如图3-70所示
%绘制相应误差曲线图
plot(tr.epoch,tr.perf,'r:',tr.epoch,tr.vperf,tr.epoch,tr.tperf,'-.');   %效果如图3-71所示
legend('训练误差曲线','验证误差曲线','测试误差曲线');    
ylabel('平方差');xlabel('时间'); 
an=sim(net,ptrans);
a=poststd(an,meant,stdt);
for i=1:3
    figure(i);
    [m(i),b(i),r(i)]=postreg(a(i,:),t(i,:));       %效果如图3-71~图3-73所示
end
net=newff(minmax(ptr),[20,3],{'tansig','purelin'},'trainlm');
[net,tr]=train(net,ptr,ttr,[],[],val,test);                     %效果如图3-74
plot(tr.epoch,tr.perf,':',tr.epoch,tr.vperf,'-.',tr.epoch,tr.tperf);   %效果如图3-75所示
legend('训练后误差曲线','验证误差曲线','测试误差曲线');
ylabel('平方差');xlabel('时间');
an=sim(net,ptrans);
a=poststd(an,meant,stdt);
for i=1:3
    figure(i);
    [m(i),b(i),r(i)]=postreg(a(i,:),t(i,:));         %效果如图3-76~图3-78所示
end
[m(1),b(1),r(1)]=postreg(a(1,:),t(1,:));
