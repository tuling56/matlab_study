close all
clear all
clc
 
Obj1.mean = 1 * [0.3; 5];
Obj2.mean = 1 * [-3; 5];
Obj3.mean = 1 * [3; -5];
Obj4.mean = 1 * [-3; -5];
 
% K-NN
Inv = 7;
K = 2;
Im = zeros(300);
for iii = 1 : 300
    for jjj = 1 : 300
        xx = (iii - 150) / 150 * Inv;
        yy = (jjj - 150) / 150 * Inv;
        d(1) = norm(Obj1.mean - [xx; yy], K);
        d(2) = norm(Obj2.mean - [xx; yy], K);
        d(3) = norm(Obj3.mean - [xx; yy], K);
        d(4) = norm(Obj4.mean - [xx; yy], K);
        [a, b] = min(d); 
        Im(iii, jjj) = b;%b是向量d中最小值的索引
    end
end
xxx = 1 : 300;
xxx = (xxx - 150) / 150 * Inv;
imagesc(xxx, xxx, Im)
hold on
plot(Obj1.mean(2), Obj1.mean(1), 'ro','linewidth',3,  'markersize', 15)
plot(Obj2.mean(2), Obj2.mean(1), 'ro','linewidth',3,  'markersize', 15)
plot(Obj3.mean(2), Obj3.mean(1), 'ro','linewidth',3,  'markersize', 15)
plot(Obj4.mean(2), Obj4.mean(1), 'ro','linewidth',3,  'markersize', 15)

% 以上代码是决策面的代码

%*****************************例1***********************************
close all
clear all
clc
%--------------------样本产生方式1一--------------------------------
Obj1.NTrain = 100;
Obj1.mean = 0.2 * [3; 5];
Obj1.SampTrain = randn(2, Obj1.NTrain) + kron(Obj1.mean, ones(1, Obj1.NTrain));
Obj1.NTest = 100;
Obj1.SampTest = randn(2, Obj1.NTest) + kron(Obj1.mean, ones(1, Obj1.NTest));

Obj2.NTrain = 100;
Obj2.mean = -0.2* [3; 5];
Obj2.SampTrain = randn(2, Obj2.NTrain) + kron(Obj2.mean, ones(1, Obj2.NTrain));
Obj2.NTest = 100;
Obj2.SampTest = randn(2, Obj2.NTest) + kron(Obj2.mean, ones(1, Obj2.NTest));
%---------------------------------------------------------------------

% K-NN Standard Code
TestMatrix = zeros(2);
K = 11;
cnt_c1 = 1;
cnt_c2 = 1;
NORM_ORDER = 2;
for iii = 1 : Obj1.NTest
    cnt_dist = 1;
    for kkk = 1 : Obj1.NTrain
        Dist(cnt_dist, 1) = norm(Obj1.SampTest(:, iii) - Obj1.SampTrain(:, kkk), NORM_ORDER);
        Dist(cnt_dist, 2) = 1;
        cnt_dist = cnt_dist + 1;
    end
    
    for kkk = 1 : Obj2.NTrain
        Dist(cnt_dist, 1) = norm(Obj1.SampTest(:, iii) - Obj2.SampTrain(:, kkk), NORM_ORDER);
        Dist(cnt_dist, 2) = -1;
        cnt_dist = cnt_dist + 1;
    end
    [a, ID] = sort(Dist(:, 1));
    SortID = Dist(ID, 2);
    if (sum(SortID(1 : K)) > 0)
        Result_c1(:, cnt_c1) = Obj1.SampTest(:, iii);
        cnt_c1 = cnt_c1 + 1;
        TestMatrix(1, 1) = TestMatrix(1, 1) + 1;
    else
        Result_c2(:, cnt_c1) = Obj1.SampTest(:, iii);
        cnt_c2 = cnt_c2 + 1;
        TestMatrix(1, 2) = TestMatrix(1, 2) + 1;
    end
 end
 
for iii = 1 : Obj2.NTest
    cnt_dist = 1;
    for kkk = 1 : Obj1.NTrain
        Dist(cnt_dist, 1) = norm(Obj2.SampTest(:, iii) - Obj1.SampTrain(:, kkk), NORM_ORDER);
        Dist(cnt_dist, 2) = 1;
        cnt_dist = cnt_dist + 1;
    end
    
    for kkk = 1 : Obj2.NTrain
        Dist(cnt_dist, 1) = norm(Obj2.SampTest(:, iii) - Obj2.SampTrain(:, kkk), NORM_ORDER);
        Dist(cnt_dist, 2) = -1;
        cnt_dist = cnt_dist + 1;
    end
    [a, ID] = sort(Dist(:, 1));
    SortID = Dist(ID, 2);
    if (sum(SortID(1 : K)) > 0)
        Result_c1(:, cnt_c1) = Obj2.SampTest(:, iii);
        cnt_c1 = cnt_c1 + 1;
        TestMatrix(2, 1) = TestMatrix(2, 1) + 1;
    else
        Result_c2(:, cnt_c1) = Obj2.SampTest(:, iii);
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

%*****************************例2**************************************
close all
clear all
clc
%  %--------------------样本产生方式2一--------------------------------
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

VecBias = - 1;
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
 %----------------------------------一--------------------------------
 
% K-NN Standard Code
TestMatrix = zeros(2);
K = 11;
cnt_c1 = 1;
cnt_c2 = 1;
NORM_ORDER = 2;
for iii = 1 : Obj1.NTest
    cnt_dist = 1;
    for kkk = 1 : Obj1.NTrain
        Dist(cnt_dist, 1) = norm(Obj1.SampTest(:, iii) - Obj1.SampTrain(:, kkk), NORM_ORDER);
        Dist(cnt_dist, 2) = 1;
        cnt_dist = cnt_dist + 1;
    end
    
    for kkk = 1 : Obj2.NTrain
        Dist(cnt_dist, 1) = norm(Obj1.SampTest(:, iii) - Obj2.SampTrain(:, kkk), NORM_ORDER);
        Dist(cnt_dist, 2) = -1;
        cnt_dist = cnt_dist + 1;
    end
    [a, ID] = sort(Dist(:, 1));
    SortID = Dist(ID, 2);
    if (sum(SortID(1 : K)) > 0)
        Result_c1(:, cnt_c1) = Obj1.SampTest(:, iii);
        cnt_c1 = cnt_c1 + 1;
        TestMatrix(1, 1) = TestMatrix(1, 1) + 1;
    else
        Result_c2(:, cnt_c1) = Obj1.SampTest(:, iii);
        cnt_c2 = cnt_c2 + 1;
        TestMatrix(1, 2) = TestMatrix(1, 2) + 1;
    end
 end
 
for iii = 1 : Obj2.NTest
    cnt_dist = 1;
    for kkk = 1 : Obj1.NTrain
        Dist(cnt_dist, 1) = norm(Obj2.SampTest(:, iii) - Obj1.SampTrain(:, kkk), NORM_ORDER);
        Dist(cnt_dist, 2) = 1;
        cnt_dist = cnt_dist + 1;
    end
    
    for kkk = 1 : Obj2.NTrain
        Dist(cnt_dist, 1) = norm(Obj2.SampTest(:, iii) - Obj2.SampTrain(:, kkk), NORM_ORDER);
        Dist(cnt_dist, 2) = -1;
        cnt_dist = cnt_dist + 1;
    end
    [a, ID] = sort(Dist(:, 1));
    SortID = Dist(ID, 2);
    if (sum(SortID(1 : K)) > 0)
        Result_c1(:, cnt_c1) = Obj2.SampTest(:, iii);
        cnt_c1 = cnt_c1 + 1;
        TestMatrix(2, 1) = TestMatrix(2, 1) + 1;
    else
        Result_c2(:, cnt_c1) = Obj2.SampTest(:, iii);
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




