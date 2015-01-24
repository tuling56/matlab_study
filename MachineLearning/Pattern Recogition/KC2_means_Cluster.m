%% 类中心变化的，初始类中心也是任意的，在聚类的过程中不断对类中心进行调整
clear all
close all
clc
%% 产生样本
N = 300;
K = 2;
for iii = 1 : N
    if iii < 101
        data(:, iii) = K * randn(2, 1) + [3; 4];
    elseif (iii > 200)
        data(:, iii) = K * randn(2, 1) + [-3; 4];
    else
        data(:, iii) = K * randn(2, 1) + [-3; -4];
    end
end
figure('Name','样本图'); 
plot(data(1, :), data(2, :), 'ro')
%% 
Nc = 3; 
Ni = 30;
P = randperm(N);
c1 = data(:, P(1));
c2 = data(:, P(2));
c3 = data(:, P(3));
epss = 0.00001;
figure('Name','动态绘图中。。。');
for kkk = 1 : Ni
    cnt1 = 1;
    cnt2 = 1;
    cnt3 = 1;
    clear Class1 Class2 Class3
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
    c11 = sum(data(:, Class1).').' / cnt1; %计算新的类中心 %sun()函数计算矩阵每列的和
    c22 = sum(data(:, Class2).').' / cnt2;
    c33 = sum(data(:, Class3).').' / cnt3;
    
    if ((norm(c11 - c1) < epss) && (norm(c22 - c2) < epss) && (norm(c33 - c3) < epss))
        break;
    end
    
    c1 = c11;%更新类中心
    c2 = c22;
    c3 = c33;
    
    hold off;
    plot(c1(1), c1(2), 'r+', 'markersize', 10, 'linewidth', 2)
    hold on;
    plot(c2(1), c2(2), 'b+', 'markersize', 10, 'linewidth', 2)
    plot(c3(1), c3(2), 'k+', 'markersize', 10, 'linewidth', 2)
    plot(data(1, Class1), data(2, Class1), 'ro')
    plot(data(1, Class2), data(2, Class2), 'bo')
    plot(data(1, Class3), data(2, Class3), 'ko')
    pause(0.5);
end

figure('Name','最后结果');
hold on;
plot(c1(1), c1(2), 'r+', 'markersize', 10, 'linewidth', 2)
plot(c2(1), c2(2), 'b+', 'markersize', 10, 'linewidth', 2)
plot(c3(1), c3(2), 'k+', 'markersize', 10, 'linewidth', 2)
plot(data(1, Class1), data(2, Class1), 'ro')
plot(data(1, Class2), data(2, Class2), 'bo')
plot(data(1, Class3), data(2, Class3), 'ko')


