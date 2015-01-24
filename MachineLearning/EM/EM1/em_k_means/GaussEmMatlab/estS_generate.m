clear 
% Cb_Cr=zeros(256,256);
% v_Cb=0;
% v_Cr=0;
%    单像素点的Cb,Cr值    %
s=0;
% s为参与运算的像素点总数 %
% for k=1:24
%     num = num2str(k);
%     fname = strcat('D:\MATLAB6p5p1\work\picture\f',num,'.bmp');
%     im=imread(fname);
%     % 读入分割出的皮肤图像 %
%     skin_im=rgb2ycbcr(im);
%     %    转换为Cb_Cr空间   %
%     skin_im=double(skin_im);
%     [M,N,k]=size(im);
%     for j=s+1:s+M*N+1
%             for i=1:M
%                 for k=1:N
%                     X(j,:) = [skin_im(i,k,2),skin_im(i,k,3)];
%                 end
%             end
%         end
%             s=M*N+s;
%             
% end
load sample_post_process3;   %  或者导入 s
sample = sample_post_process;
estS = gmmb_em(sample, 'init', 'cmeans1', 'components', 8, 'thr', 1e-8);
for Cb=0:255;
for Cr=0:255;
    Y(Cb+1,Cr+1)=0;
for i=1:8
    
    Y(Cb+1,Cr+1) = estS.weight(i,1)*exp(-([Cb;Cr]-estS.mu(:,i))'*inv(estS.sigma(:,:,i))*([Cb;Cr]-estS.mu(:,i))/2)/(2*pi*sqrt(det(estS.sigma(:,:,i))))+Y(Cb+1,Cr+1);
end
end
end
figure;
mesh(Y);
% save estS_post_process_cmeans_2 estS;