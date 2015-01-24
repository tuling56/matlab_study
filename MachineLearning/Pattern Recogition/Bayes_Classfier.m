 
close all
clear all
clc
%%
% *此程序只包括分类器的实现*
N = 50;
u1 = [0.8, 0.6];
u2 = [-0.8, - 0.6];
Cov1 = 0.3 * [0.8, 0.2; 0.2, 8];
%Cov1 = 0.3 * [1, 0; 0, 1];
Cov2 = 0.6 * [1, 0; 0, 1];
% Cov2 = Cov1;
 
P1 = 0.5;
P2 = 1 - P1;
nn = 1 : N;
C = 4;
xx = (nn - N / 2) / N * C;
for iii = 1 : N
    for jjj = 1 : N
        x(1) = (iii - N / 2) / N * C;
        x(2) = (jjj - N / 2) / N * C;
        
        f1(iii, jjj) = 1 / sqrt((2 * pi)) / sqrt(det(Cov1)) * exp(-1 / 2 * (x - u1) * inv(Cov1) * (x - u1).');
        f2(iii, jjj) = 1 / sqrt((2 * pi)) / sqrt(det(Cov2)) * exp(-1 / 2 * (x - u2) * inv(Cov2) * (x - u2).');
    end
end
 
figure; mesh(f1);
figure; mesh(f2);
 
for iii = 1 : N
    for jjj = 1 : N
        [a, b] = max([f1(iii, jjj), f2(iii, jjj)]);
        yy(iii, jjj) = a;
        mask(iii, jjj) = b - 1;
    end
end
% figure; imagesc(mask);
 
for iii = 1 : N
    [a, b] = max(abs(diff(mask(:, iii))));
    border(iii, 1) =  C * (iii - N / 2) / N; %决策面的Y坐标   
    border(iii, 2) =  C * (b - N / 2) / N;   %决策面的X坐标    
end
 
figure; contour(xx, xx, yy.', 40, 'linewidth', 2)
% colormap(jet)
 
hold on
plot(border(:, 2), border(:, 1), 'r.', 'markersize', 15, 'linewidth', 3)
