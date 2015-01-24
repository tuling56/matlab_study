close all
clear all
clc
 
N = 1000;
C = 10;
nn = 1 : N;
xx = C * (nn - N) / N;
y = zeros(N);
 
 
Nsam = 500;
samp = randn(2, Nsam) ;
 
for iii = 1 : N
    for jjj = 1 : N
        x(1) = C * (iii - N / 2) / N;
        x(2) = C * (jjj - N / 2) / N;
        
        for kkk = 1 : Nsam
            if(abs(x(1) - samp(1, kkk)) < 0.5 && abs(x(2) - samp(2, kkk)) < 0.5)
                y(iii, jjj) = y(iii, jjj) + 1;
            end
        end
    end
end
 
figure; mesh(xx, xx, y)
% figure; imagesc(xx, xx, y)
