clear all;
n = [0; 1; -0.5; 0.5];
a = softmax(n)
subplot(2,1,1), bar(n), ylabel('n')
subplot(2,1,2), bar(a), ylabel('a')
