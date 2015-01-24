clear all;
gW = rand(3,2);
lp.lr = 0.5;
lp.mc = 0.8;
ls = [];
[dW,ls] = learngdm([],[],[],[],[],[],[],gW,[],[],lp,ls)
