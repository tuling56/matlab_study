% function [Img]  = niblak(image ,Wnd, k) 
%% % Niblack 
%pixel = ( pixel >  mean + k * standard_deviation) ? object : background
%image= orginal Image
% Wnd = size of WindoW 
% Parameter 1: is the k value. The default value is 0.2 for bright objects and -0.2 for dark objects. Any other number than 0 will change the default value. 
% Maryam Basij
% Bioelectric,Esfahan university,Iran
% Email: n_basij@yahoo.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I=imread('binaryzaimg.bmp');
Wnd=2;
k=0.2;
I=rgb2gray(I);
[row column]= size(I);
for i = Wnd+1:row-Wnd
   for j = Wnd+1:column-Wnd
      A = I(i-Wnd:i+Wnd,j-Wnd:j+Wnd); 
     A_mean= mean2(A);
     A_std=std2(A);
     if(I(i,j)>(A_mean + 0.2* A_std) )
         Img(i,j)=0;
     else
         Img(i,j)=255;
     end
     
     end;
end;
figure,imshow(Img)