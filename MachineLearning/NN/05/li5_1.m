 clear all;
%输入向量
P=[0.1826 0.6325;0.3651 0.3162;0.5477 0.3162;0.7303 0.6325];
T=[1 0];
%内星规则根据期望向量进行学习。对网络进行初始化
[R,Q]=size(P);
[S,Q]=size(T);
W=zeros(S,R);
max_epoch=10;
lp.lr=0.65;
%对内星规则网络进行训练
for epoch=1:max_epoch
    for q=1:Q
        A=T(:,q);
        dW=learnis(W,P(:,q),[],[],A,[],[],[],[],[],lp,[]);
        W=W+dW;
    end
end
disp('学习速率为0.65时权值向量：')
W
%改变学习率
lp.lr=0.25;
for epoch=1:max_epoch
    for q=1:Q
        A=T(:,q);
        dW=learnis(W,P(:,q),[],[],A,[],[],[],[],[],lp,[]);
        W=W+dW;
    end
end
disp('学习速率为0.25时权值向量：')
W
