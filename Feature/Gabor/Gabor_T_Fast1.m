%
%  do the gabor convolution on Imaga
%
function [gabordata]=Gabor_T_Fast1(img,gabor_img_h,gabor_img_w,Gabor_num,GaborReal, GaborImg)

A = im2double(img);
B = [];
for j = 1 : Gabor_num
    face_real   =   conv2( A, GaborReal(:,:,j), 'same' );
    face_img    =   conv2( A, GaborImg(:,:,j), 'same' );
    face_mode   =   sqrt(face_real.^2+face_img.^2);%    
    
% --------------------------------------------------------------------------
%               Note(Jing Huai): show the convolution result
% --------------------------------------------------------------------------

%     figure(1);
%     subplot(5 ,8 ,j ), imshow ( face_mode ,[]);
    
    face_mode   =   imresize( face_mode, [gabor_img_h, gabor_img_w], 'bilinear' );
    face_mode   =   face_mode(:);
    tmean       =   mean( face_mode );
    tstd        =   std( face_mode );    
    face_mode   =   ( face_mode - tmean )/tstd;       
    B           =   [ B; face_mode];
end
gabordata=B;
