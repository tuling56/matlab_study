clear all;
gW = rand(3,2);
lp.lr = 0.5;
dW = learngd([],[],[],[],[],[],[],gW,[],[],lp,[])
