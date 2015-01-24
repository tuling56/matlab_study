%% 数据分布不具有各相同性，分类前进行特征空间变换，等价于变换距离测度
clear all
close all
clc
%% 产生样本，并对数据进行变换
N = 300;
K = 1;
for iii = 1 : N
    if iii < 101
        data1(:, iii) = K * randn(2, 1) + [3; 4];
    elseif (iii > 200)
        data1(:, iii) = K * randn(2, 1) + [-3; 4];
    else
        data1(:, iii) = K * randn(2, 1) + [-3; -4];
    end
end

subplot(1,2,1)
plot(data1(1, :), data1(2, :), 'ro')
title('原始数据')

R = randn(2);
R = R' * R;
for iii = 1 : N
    data2(:, iii) = R * data1(:, iii);
end

subplot(1,2,2)
plot(data2(1, :), data2(2, :), 'ro')
title('特征空间变换后的数据')


for iii = 1 : N
    data(:, iii) = inv(R) * data2(:, iii);
end
%% 
Nc = 3; 
Ni = 30;
P = randperm(N);
c1 = data(:, P(1));
c2 = data(:, P(2));
c3 = data(:, P(3));
epss = 0.00001;
figure('Name','更新类中心，动态绘图中。。。。');
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
    c11 = sum(data(:, Class1).').' / cnt1;
    c22 = sum(data(:, Class2).').' / cnt2;
    c33 = sum(data(:, Class3).').' / cnt3;
    
    if ((norm(c11 - c1) < epss) && (norm(c22 - c2) < epss) && (norm(c33 - c3) < epss))
        break;
    end
    
    c1 = c11;
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
    pause(1.5);
end
cc1 = (R) * c1;
cc2 = (R) * c2;
cc3 = (R) * c3;
figure('Name','特征空间变换后数据的最后分类结果'); hold on;
plot(cc1(1), cc1(2), 'r+', 'markersize', 10, 'linewidth', 2)
plot(cc2(1), cc2(2), 'b+', 'markersize', 10, 'linewidth', 2)
plot(cc3(1), cc3(2), 'k+', 'markersize', 10, 'linewidth', 2)
plot(data2(1, Class1), data2(2, Class1), 'ro')
plot(data2(1, Class2), data2(2, Class2), 'bo')
plot(data2(1, Class3), data2(2, Class3), 'ko')


