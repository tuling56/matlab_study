%% 本程序是单幅图像的分解和重构，采用的是Lalacian变换的方法

%%
clc;
clear all;
% -------------------------------------------------------------------------
%                               get signal
%--------------------------------------------------------------------------
xn = imread('lena.bmp');
xn = double(xn);
% -------------------------------------------------------------------------
%                               get filters
%--------------------------------------------------------------------------
h = [0.037828455506995, -0.023849465019380, -0.11062440441842, ...
     0.37740285561265];	
h = [h, 0.85269867900940, fliplr(h)];
    
g = [-0.064538882628938, -0.040689417609558, 0.41809227322221];
g = [g, 0.78848561640566, fliplr(g)];
        
% -------------------------------------------------------------------------
%                           Laplacian decomposition
%--------------------------------------------------------------------------
disp(' ');
disp('Taking Laplacian pyramid decomposition');
    tic;
    [c,d] = lpdec(xn, h, g);
    toc;
disp('Taking Laplacian pyramid reconstruction');
    tic;
    yn = lprec(c, d, h, g);
    toc;
  
en = xn-yn;
fprintf('Reconstruction error is : %d\n', norm(en)/norm(xn));
disp(' ');

% -------------------------------------------------------------------------
%                           plot figures
%--------------------------------------------------------------------------
cmax = max(c(:));
dispdata = [d, [c;cmax*ones(size(c))] ];
figure(1), clf;
    imagesc(dispdata);
    colormap(gray);
    title('Laplacian pyramid decomposition', 'fontsize',12, 'color','blue');

figure(2), clf;
    subplot(1,2,1);
        imshow(uint8(xn));
        title('Original image', 'fontsize',12, 'color','blue');
    subplot(1,2,2);
        imshow(uint8(yn));
        title('Reconstructed image', 'fontsize',12, 'color','blue');
