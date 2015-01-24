% function [Img]  = sauvola(image ,Wnd, k,r) 
%% % Sauvola 
%%% sauvola----> pixel = (pixel > mean * (1 + k *( standard_deviation / r - 1))) ? object : background
%%Parameter 1: is the k value. The default value is 0.5. Any other number than 0 will change the default value. 
%image= orginal Image
% Wnd = size of WindoW 
%%Parameter 2: is the r value. The default value is 128. Any other number
%%than 0 will change the default value 

% Maryam Basij
% Bioelectric,Esfahan university,Iran
% Email: n_basij@yahoo.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I=imread('binaryzaimg.bmp');
Wnd=2;
k=0.2;
r=128;
image=I;
[row column]= size(image);
for i = Wnd+1:row-Wnd
   for j = Wnd+1:column-Wnd
      A = image(i-Wnd:i+Wnd,j-Wnd:j+Wnd); 
     A_mean= mean2(A);
     A_std=std2(A);
     if(image(i,j)> A_mean*(1+k*(A_std/(r-1))) )
         Img(i,j)=0;
     else
         Img(i,j)=255;
     end
     
     end;
end;
figure,imshow(Img);