clear all
close all

tt = 1 : 1000;
tt = tt / 1000;

y1 = randn(1) * exp(j * 2 * pi * 100 * tt) + randn(1) * exp(j * 2 * pi * 200 * tt);
% y1 = y1 + 0.3 * (randn(size(y1)) + j * randn(size(y1)));

y2 = randn(1) * exp(j * 2 * pi * 100 * tt) + randn(1) * exp(j * 2 * pi * 200 * tt);
% y2 = y2 + 0.3 * (randn(size(y1)) + j * randn(size(y1)));

y3 = randn(1) * exp(j * 2 * pi * 350 * tt) + randn(1) * exp(j * 2 * pi * 250 * tt);
% y3 = y3 + 0.3 * (randn(size(y1)) + j * randn(size(y1)));

figure; plot(real(y1), 'linewidth', 1);
figure; plot(real(y2), 'linewidth', 1);
figure; plot(real(y3), 'linewidth', 1);

figure; plot(abs(fft(y1)), 'linewidth', 1);
figure; plot(abs(fft(y2)), 'linewidth', 1);
figure; plot(abs(fft(y3)), 'linewidth', 1);
