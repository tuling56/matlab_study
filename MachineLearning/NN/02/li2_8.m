 clear all;
P=[0 0 1 1;0 1 0 1];
T=[0 1 1 1];
net=newp(minmax(P),1);
Y=sim(net,P)
net.trainParam.epochs=20;
net=train(net,P,T);
Y=sim(net,P);
err1=mae(Y-T)
