%% 已知类中心聚类，即类中心是固定的，x属于到各类中心最近的类
clear all
close all
clc
%% 产生样本
N = 300;
for iii = 1 : N
    if iii < 101
        data(:, iii) = randn(2, 1) + [3; 4];
    elseif (iii > 200)
        data(:, iii) = randn(2, 1) + [-3; 4];
    else
        data(:, iii) = randn(2, 1) + [-3; -4];
    end
end

figure('Name','样本图'); 
plot(data(1, :), data(2, :), 'o')

%% 共有3类,类重心如下：
Nc = 3; 
c1 = [3; 4];
c2 = [-3; 4];
c3 = [-3; -4];

cnt1 = 1;
cnt2 = 1;
cnt3 = 1;
for iii = 1 : N
    dist(1) = norm(data(:, iii) - c1, 2);
    dist(2) = norm(data(:, iii) - c2, 2);
    dist(3) = norm(data(:, iii) - c3, 2);
    [a, b] = min(dist);
    
    switch b
        case 1
            Class1(cnt1) = iii;    
            cnt1 = cnt1 + 1;
        case 2
            Class2(cnt2) = iii;    
            cnt2 = cnt2 + 1;
        case 3
            Class3(cnt3) = iii;    
            cnt3 = cnt3 + 1;
    end
end

figure; hold on;
plot(data(1, Class1), data(2, Class1), 'ro')
plot(data(1, Class2), data(2, Class2), 'bo')
plot(data(1, Class3), data(2, Class3), 'ko')
%%

