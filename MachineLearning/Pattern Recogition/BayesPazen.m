%本程序采用的是Bayes分类中非参数估计中的的Pazen窗估计方法
close all
clear all
clc
%  第一步：初始化训练样本和测试样本
%分类一的训练样本
Obj1.mean = [0; 0]
Obj1.NTrain = 200;
cnt1 = 1;
for iii = 1 : (1000 * Obj1.NTrain)
    tmp = (rand(2, 1) - 0.5) * 10 - Obj1.mean;
    if (norm(tmp - Obj1.mean) < 1 && norm(tmp - Obj1.mean) > 0.8 && tmp(2) > 0)
        Obj1.SampTrain(:, cnt1) = tmp;
        cnt1 = cnt1 + 1;
    end
    if(cnt1 == (Obj1.NTrain + 1))
        break;
    end
end
figure;
plot(Obj1.SampTrain(1, :), Obj1.SampTrain(2, :), 'r+', 'linewidth', 1, 'markersize', 5)
hold on;

%分类一的测试样本
Obj1.NTest = 100;
cnt1 = 1;
for iii = 1 : (1000 * Obj1.NTest)
    tmp = (rand(2, 1) - 0.5) * 10 - Obj1.mean;
    if (norm(tmp - Obj1.mean) < 1 && norm(tmp - Obj1.mean) > 0.8 && tmp(2) > 0)
        Obj1.SampTest(:, cnt1) = tmp;
        cnt1 = cnt1 + 1;
    end
    if(cnt1 == (Obj1.NTest + 1))
        break;
    end
end
plot(Obj1.SampTest(1, :), Obj1.SampTest(2, :), 'ro', 'linewidth', 1, 'markersize', 5)

%分类二的训练样本
VecBias = -0.0;
Obj2.mean = [-0.5;-0.0];
Obj2.NTrain = 200;
cnt1 = 1;
for iii = 1 : (1000 * Obj2.NTrain)
    tmp = (rand(2, 1) - 0.5) * 10 - Obj2.mean;
    if (norm(tmp - Obj2.mean) < 1 && norm(tmp - Obj2.mean) > 0.8 && tmp(2) < 0)
        Obj2.SampTrain(:, cnt1) = tmp - [0; VecBias];
        cnt1 = cnt1 + 1;
    end
    if(cnt1 == (Obj2.NTrain + 1))
        break;
    end
end
plot(Obj2.SampTrain(1, :), Obj2.SampTrain(2, :), 'b+', 'linewidth', 1, 'markersize', 5)

%分类二的测试样本
Obj2.NTest = 100;
cnt1 = 1;
for iii = 1 : (1000 * Obj2.NTest)
    tmp = (rand(2, 1) - 0.5) * 10 - Obj2.mean;
    if (norm(tmp - Obj2.mean) < 1 && norm(tmp - Obj2.mean) > 0.8 && tmp(2) < 0)
        Obj2.SampTest(:, cnt1) = tmp - [0; VecBias];
        cnt1 = cnt1 + 1;
    end
    if(cnt1 == (Obj2.NTest + 1))
        break;
    end
end
plot(Obj2.SampTest(1, :), Obj2.SampTest(2, :), 'bo', 'linewidth', 1, 'markersize', 5)
 
% Evaluation
h = 20;  %窗体的宽度
TestMatrix = zeros(2);
cnt_c1 = 1;
cnt_c2 = 1;

for iii = 1 : Obj1.NTest
    y1 = 0;
    y2 = 0;
    for kkk = 1 : Obj1.NTrain
        y1 = y1 + exp(-0.5 * h * (norm(Obj1.SampTest(:, iii) - Obj1.SampTrain(:, kkk)) ^2));
    end
    
    for kkk = 1 : Obj2.NTrain
        y2 = y2 + exp(-0.5 * h * (norm(Obj1.SampTest(:, iii) - Obj2.SampTrain(:, kkk)) ^2));
    end
    
    if(y1 > y2)
        Result_c1(:, cnt_c1) = Obj1.SampTest(:, iii);
        cnt_c1 = cnt_c1 + 1;
        TestMatrix(1, 1) = TestMatrix(1, 1) + 1;
    else
        Result_c2(:, cnt_c2) = Obj1.SampTest(:, iii);
        cnt_c2 = cnt_c2 + 1;
        TestMatrix(1, 2) = TestMatrix(1, 2) + 1;
    end
end
 
for iii = 1 : Obj2.NTest
    y1 = 0;
    y2 = 0;
    for kkk = 1 : Obj1.NTrain
        y1 = y1 + exp(-0.5 * h * (norm(Obj2.SampTest(:, iii) - Obj1.SampTrain(:, kkk)) ^2));
    end
    
    for kkk = 1 : Obj2.NTrain
        y2 = y2 + exp(-0.5 * h * (norm(Obj2.SampTest(:, iii) - Obj2.SampTrain(:, kkk)) ^2));
    end
    
    if(y1 > y2)
        Result_c1(:, cnt_c1) = Obj2.SampTest(:, iii);
        cnt_c1 = cnt_c1 + 1;
        TestMatrix(2, 1) = TestMatrix(2, 1) + 1;
    else
        Result_c2(:, cnt_c2) = Obj2.SampTest(:, iii);
        cnt_c2 = cnt_c2 + 1;
        TestMatrix(2, 2) = TestMatrix(2, 2) + 1;
    end
end
 
TestMatrix(1, :) = TestMatrix(1, :) / Obj1.NTest;
TestMatrix(2, :) = TestMatrix(2, :) / Obj2.NTest;
 
TestMatrix

figure;
plot(Result_c1(1, :), Result_c1(2, :), 'ro', 'linewidth', 2, 'markersize', 10)
hold on
plot(Result_c2(1, :), Result_c2(2, :), 'bo', 'linewidth', 2, 'markersize', 10)

% plot(Obj1.SampTrain(1, :), Obj1.SampTrain(2, :), 'r+', 'linewidth', 2, 'markersize', 10)
% plot(Obj2.SampTrain(1, :), Obj2.SampTrain(2, :), 'b+', 'linewidth', 2, 'markersize', 10)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LIKELIHOOD
N = 200;
C = 4
nn = 1 : N;
xx = C * (nn - N / 2) / N;
y1 = zeros(N);
 
for iii = 1 : N
    iii;
    for jjj = 1 : N
        x(1) = C * (iii - N / 2) / N;
        x(2) = C * (jjj - N / 2) / N;
        
        for kkk = 1 : Obj1.NTrain
            y1(iii, jjj) = y1(iii, jjj) + exp(-0.5 * h * (norm(x.' - Obj1.SampTrain(:, kkk)) ^2));
        end
    end
end
 
y2 = zeros(N);
 
for iii = 1 : N
    iii;
    for jjj = 1 : N
        x(1) = C * (iii - N / 2) / N;
        x(2) = C * (jjj - N / 2) / N;
        
        for kkk = 1 : Obj2.NTrain
            y2(iii, jjj) = y2(iii, jjj) + exp(-0.5 * h * (norm(x.' - Obj2.SampTrain(:, kkk)) ^2));
        end
    end
end

for iii = 1 : N
    for jjj = 1 : N
        [a, b] = max([y1(iii, jjj), y2(iii, jjj)]);
        yy(iii, jjj) = a;
        mask(iii, jjj) = b - 1;
    end
end
figure; imagesc(mask);

for iii = 1 : N
    [a, b] = max(abs(diff(mask(iii, :))));
    border(iii, 1) =  C * (iii - N / 2) / N;
    border(iii, 2) =  C * (b - N / 2) / N;     
end

figure; contour(xx, xx, yy.', 40, 'linewidth', 2)
colormap(jet)
 
hold on
plot(border(:, 1), border(:, 2), 'r.', 'markersize', 15, 'linewidth', 3)

