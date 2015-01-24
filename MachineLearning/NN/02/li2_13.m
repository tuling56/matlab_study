 clear all;
n=-10:0.1:10;     %以步长为0.1建立一个数组
a=hardlim(n);
b=hardlims(n);
plot(n,a,'bv');
hold on;
plot(n,b,'rp');
hold off
