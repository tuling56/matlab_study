clear all;
for n=50:80
    if mod(n,6)~=0
        continue;
    end
    break;
end
disp('在50到80的数值中，第一个能被6整除的数值为：')
disp(n)
