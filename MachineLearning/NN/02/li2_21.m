clear all;
Z1 = [1 2 4;3 4 1];
Z2 = [-1 2 2; -5 -6 1];
B = [0; -1];
Z = {Z1, Z2, concur(B,3)};
N = netprod(Z)
