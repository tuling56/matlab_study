clear all;
close all;
clc;


%%dataset1, EM randomly initial means and coviance
r=3;k=2;
[ga1,ll1]=em1r(r,k);

%%dataset2, EM randomly initial means and coviance
r=3;k=3;
[ga2,ll2]=em2r(r,k);

%%dataset1, EM initial means and coviance with k-mean
r=3;k=2;
[ga3,ll3]=em1k(r,k);
%%dataset2, EM initial means and coviance with k-mean
r=3;k=3;
[ga4,ll4]=em2k(r,k);