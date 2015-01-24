clear all;
p = rand(2,1);
e = rand(3,1);
lp.lr = 0.5;
dW = learnwh([],p,[],[],[],[],e,[],[],[],lp,[])
