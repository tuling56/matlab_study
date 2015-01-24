%Matlab RGBתHSV
I = imread('1.png');
HSV = rgb2hsv(I);
H = HSV(:, :, 1);
S = HSV(:, :, 2);
V = HSV(:, :, 3);
figure;
subplot(2, 3, 1); imshow(I);
subplot(2, 3, 2); imshow(HSV);

subplot(2, 3, 4); imshow(H);
subplot(2, 3, 5); imshow(S);
subplot(2, 3, 6); imshow(V);