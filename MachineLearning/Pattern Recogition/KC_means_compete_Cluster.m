clear all
close all
clc

N = 300;
%% 产生样本
K = 1;
for iii = 1 : N
    if iii < 101
        data(:, iii) = K * randn(2, 1) + [3; 4];
    elseif (iii > 200)
        data(:, iii) = K * randn(2, 1) + [-3; 4];
    else
        data(:, iii) = K * randn(2, 1) + [-3; -4];
    end
end

figure; plot(data(1, :), data(2, :), 'ro')

%% 
Nc = 3; 
Ni = 30;
P = randperm(N);
data1 = data;
for iii = 1 : 300
    data(:, iii) = data1(:, P(iii));
end
c1 = data(:, P(1));
c2 = data(:, P(2));
c3 = data(:, P(3));
epss = 0.00001;
cnt1 = 1;
cnt2 = 1;
cnt3 = 1;
figure;
h2 = 0.0000;
for iii = 1 : N
     dist(1) = norm(data(:, iii) - c1, 2);
     dist(2) = norm(data(:, iii) - c2, 2);
     dist(3) = norm(data(:, iii) - c3, 2);
     [a, b] = min(dist);
     
     switch b
         case 1
             Class1(cnt1) = iii;
             cnt1 = cnt1 + 1;
             c1 = ((cnt1 - 1) * c1 + data(:, iii)) / cnt1;
             c2 = c2 + h2 * (data(:, iii) - c2);
             c3 = c3 + h2 * (data(:, iii) - c3);
         case 2
             Class2(cnt2) = iii;
             cnt2 = cnt2 + 1;
             c1 = c1 + h2 * (data(:, iii) - c1);
             c2 = ((cnt2 - 1) * c2 + data(:, iii)) / cnt2;
             c3 = c3 + h2 * (data(:, iii) - c3);
         case 3
             Class3(cnt3) = iii;
             cnt3 = cnt3 + 1;
             c1 = c1 + h2 * (data(:, iii) - c1);
             c2 = c2 + h2 * (data(:, iii) - c2);
             c3 = ((cnt3 - 1) * c3 + data(:, iii)) / cnt3;
     end
     
    hold off;
    plot(c1(1), c1(2), 'r+', 'markersize', 10, 'linewidth', 2)
    hold on;
    plot(c2(1), c2(2), 'b+', 'markersize', 10, 'linewidth', 2)
    plot(c3(1), c3(2), 'k+', 'markersize', 10, 'linewidth', 2)
    try
        plot(data(1, Class1), data(2, Class1), 'ro')
    end
    try
        plot(data(1, Class2), data(2, Class2), 'bo')
    end
    try
        plot(data(1, Class3), data(2, Class3), 'ko')
    end
    pause(0.1);
end

