close all
clear all
clc
%%线性分类器
% *感知器算法模型*
Obj1.NTrain = 100;
Obj1.mean = 2.5 * [3; 5];
Obj1.SampTrain = randn(2, Obj1.NTrain) + kron(Obj1.mean, ones(1, Obj1.NTrain));
Obj1.NTest = 100;
Obj1.SampTest = randn(2, Obj1.NTest) + kron(Obj1.mean, ones(1, Obj1.NTest));
 
Obj2.NTrain = 100;
Obj2.mean = -0.0 * [3; 5];
Obj2.SampTrain = randn(2, Obj2.NTrain) + kron(Obj2.mean, ones(1, Obj2.NTrain));
Obj2.NTest = 100;
Obj2.SampTest = randn(2, Obj2.NTest) + kron(Obj2.mean, ones(1, Obj2.NTest));
 
% Perceptron
TestMatrix = zeros(2);
cnt_c1 = 1;
cnt_c2 = 1;
% Trainning
W = 10 * randn(3, 1);
% W(3) = -1;
coeff = 0.7;
% W(1 : 2) = W(1 : 2) / norm(W(1 : 2));
tt = 1 : 1000;
tt = (tt - 500) * 0.01;
figure;
plot(Obj1.SampTrain(1, :), Obj1.SampTrain(2, :), 'ro', 'linewidth', 2, 'markersize', 10)
hold on;
plot(Obj2.SampTrain(1, :), Obj2.SampTrain(2, :), 'bo', 'linewidth', 2, 'markersize', 10)
 
WW = W;
WW = WW / norm(WW);
plot(tt * W(2), -1 * (WW(1) * tt + WW(3)), 'r', 'linewidth', 3)
% 以上部分是产生初始化训练样本，下面紧接着是用训练样本初始化权向量
for jjj = 1: 1000
    Ecnt = 0;
    TMP_update = zeros(3, 1);
    for kkk = 1 : Obj1.NTrain
        TMP_Tr(1:2, 1) = Obj1.SampTrain(:, kkk);
        TMP_Tr(3, 1) = 1;
        yy = W.' * TMP_Tr;
        if (yy <= 0)
            TMP_update = TMP_update + (-1) * TMP_Tr;
            Ecnt = Ecnt + 1;
        end
    end
    
    for kkk = 1 : Obj2.NTrain
        TMP_Tr(1:2, 1) = Obj2.SampTrain(:, kkk);
        TMP_Tr(3, 1) = 1;
        yy = W.' * TMP_Tr;
        if (yy >= 0)
            TMP_update = TMP_update + (1) * TMP_Tr;
            Ecnt = Ecnt + 1;
        end
    end
%     coeff = 1000 / jjj;
    W = W - coeff * TMP_update;
    
%    pause(0.2);
   WW = W;
   WW = WW / norm(WW);
%    plot(tt , -1 * (WW(1) / WW(2) * tt + WW(3) / WW(2)), 'linewidth', 3)
   if (Ecnt == 0)
       break;
   end
end
 
% 以下是对测试样本用感知器算法进行分类 
for kkk = 1 : Obj1.NTest
    TMP_Tr(1:2, 1) = Obj1.SampTest(:, kkk);
    TMP_Tr(3, 1) = 1;
    yy = W.' * TMP_Tr;
    if (yy > 0)
        Result_c1(:, cnt_c1) = Obj1.SampTest(:, kkk);
        cnt_c1 = cnt_c1 + 1;
        TestMatrix(1, 1) = TestMatrix(1, 1) + 1;
    else
        Result_c2(:, cnt_c2) = Obj1.SampTest(:, kkk);
        cnt_c2 = cnt_c2 + 1;
        TestMatrix(1, 2) = TestMatrix(1, 2) + 1;
    end
end
    
for kkk = 1 : Obj2.NTest
    TMP_Tr(1:2, 1) = Obj2.SampTest(:, kkk);
    TMP_Tr(3, 1) = 1;
    yy = W.' * TMP_Tr;
    if (yy > 0)    
        Result_c1(:, cnt_c1) = Obj2.SampTest(:, kkk);
        cnt_c1 = cnt_c1 + 1;
        TestMatrix(2, 1) = TestMatrix(2, 1) + 1;
    else
        Result_c2(:, cnt_c2) = Obj2.SampTest(:, kkk);
        cnt_c2 = cnt_c2 + 1;
        TestMatrix(2, 2) = TestMatrix(2, 2) + 1;
    end
end
 
TestMatrix(1, :) = TestMatrix(1, :) / Obj1.NTest;
TestMatrix(2, :) = TestMatrix(2, :) / Obj2.NTest;
 
TestMatrix
 
figure;
try
    plot(Result_c1(1, :), Result_c1(2, :), 'ro', 'linewidth', 2, 'markersize', 10)
end
hold on
try
    plot(Result_c2(1, :), Result_c2(2, :), 'bo', 'linewidth', 2, 'markersize', 10)
end
 
plot(Obj1.SampTrain(1, :), Obj1.SampTrain(2, :), 'r+', 'linewidth', 2, 'markersize', 10)
 
plot(Obj2.SampTrain(1, :), Obj2.SampTrain(2, :), 'b+', 'linewidth', 2, 'markersize', 10)
WW = W;
WW = WW / norm(WW);
plot(tt , -1 * (WW(1) / WW(2) * tt + WW(3) / WW(2)), 'linewidth', 3)

