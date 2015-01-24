close all
clear all
clc
% 此程序包括分类器的训练和实现。

Obj1.NTrain = 100;
Obj1.mean = 0.3 * [3; 5];
Obj1.SampTrain = randn(2, Obj1.NTrain) + kron(Obj1.mean, ones(1, Obj1.NTrain));
Obj1.NTest = 100;
Obj1.SampTest = randn(2, Obj1.NTest) + kron(Obj1.mean, ones(1, Obj1.NTest));

Obj2.NTrain = 100;
Obj2.mean = -0.3* [3; 5];
Obj2.SampTrain = randn(2, Obj2.NTrain) + kron(Obj2.mean, ones(1, Obj2.NTrain));
Obj2.NTest = 100;
Obj2.SampTest = randn(2, Obj2.NTest) + kron(Obj2.mean, ones(1, Obj2.NTest));

% Evaluation
TestMatrix = zeros(2);
cnt_c1 = 1;
cnt_c2 = 1;
for iii = 1 : Obj1.NTest
    y1 = 0;
    y2 = 0;
    for kkk = 1 : Obj1.NTrain
        y1 = y1 + exp(-0.5 * (norm(Obj1.SampTest(:, iii) - Obj1.SampTrain(:, kkk)) ^2));
    end
    
    for kkk = 1 : Obj2.NTrain
        y2 = y2 + exp(-0.5 * (norm(Obj1.SampTest(:, iii) - Obj2.SampTrain(:, kkk)) ^2));
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
        y1 = y1 + exp(-0.5 * (norm(Obj2.SampTest(:, iii) - Obj1.SampTrain(:, kkk)) ^2));
    end
    
    for kkk = 1 : Obj2.NTrain
        y2 = y2 + exp(-0.5 * (norm(Obj2.SampTest(:, iii) - Obj2.SampTrain(:, kkk)) ^2));
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

plot(Obj1.SampTrain(1, :), Obj1.SampTrain(2, :), 'r+', 'linewidth', 2, 'markersize', 10)
plot(Obj2.SampTrain(1, :), Obj2.SampTrain(2, :), 'b+', 'linewidth', 2, 'markersize', 10)

