clear all
close all
clc

for iii = 1 : 10
    t = rand(1);
    if(t < 0.3)
        x(iii) = 1;
    elseif((t >= 0.3) && (t < 0.6))
        x(iii) = 2;
    else
        x(iii) = 3;
    end
    
    t = rand(1);
    if(t < 0.3)
        y(iii) = 1;
    elseif((t >= 0.3) && (t < 0.6))
        y(iii) = 2;
    else
        y(iii) = 3;
    end
end

figure; 
plot(x, 'r', 'linewidth', 1);
hold on;
plot(y, 'b', 'linewidth', 2)
figure;
plot(x ~= y,  'linewidth', 1)
sum(x ~= y)% 统计x~=y的个数；
