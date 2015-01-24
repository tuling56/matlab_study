clear all;
%输入向量
T=[0.1826 0.6325;0.3651 0.3162;0.5477 0.3162;0.7303 0.6325];
P=[1 0];
%该网络的每个期望输出向量强迫为网络的输出。对网络进行初始化
[R,Q]=size(P);
[S,Q]=size(T);
W=zeros(S,R);
max_epoch=10;
lp.lr=0.3;
%对外星学习规则网络进行训练
for epoch=1:max_epoch
    for q=1:Q
        A=T(:,q);
        dW=learnos(W,P(:,q),[],[],A,[],[],[],[],[],lp,[]);
        W=W+dW;
    end
end
%训练完成，将能够回忆起被记忆在网络中的第一个期望输出向量的近似值：
Prest=[1];
A=purelin(W*Prest)
