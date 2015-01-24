clear all;
p = rand(2,1);
a = rand(3,1);
lp.lr = 0.5;
dW = learnh([],p,[],[],a,[],[],[],[],[],lp,[])
