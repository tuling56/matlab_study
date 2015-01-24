clear all;
p = rand(2,1);
a = rand(3,1);
w = rand(3,2);
lp.lr = 0.5;
dW = learnos(w,p,[],[],a,[],[],[],[],[],lp,[])
