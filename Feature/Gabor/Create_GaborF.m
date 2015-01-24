%function [opts] = Create_GaborF (ipts, par)
%
%
% This function aims to create the argumented Gabor feature.
% 
%   input
%         ipts.              input data structure
%              dat           3d image data matrix, each dat(:,:,i) is an (downsampled) 
%                            image matrix.
%         par.               input parameter structure
%              ds_w          the downsample image's width in Gabor
%              ds_h          the downsample image's heigth in Gabor
%              ke_w          Gabor kernel's width
%              ke_h          Gabor kernel's heigth
%              Kmax          Gabor kernel's para, default(pi/2)
%              f             Gabor kernel's para, default(sqrt(2))
%              sigma         Gabor kernel's para, default(pi or 1.5pi)
%              Gabornum      Gabor kernel's number
%
%  output
%        opts.              output data structure
%            gdat           Gabor feature of training data, each column is
%                           the argumented gabor feature vector of a sample
%--------------------------------------------------------------------------
%                           Note(Zhen Cui): every Gabor kernel spans a
%                           vector of ds_w*ds_h, and then concatenated the
%                           Gabornum thus vector.
%--------------------------------------------------------------------------
%
%  Copyright  Mike YANG, PolyU, Hong Kong
%  reference: Liu,C.,Wechsler,H.:Gabor Feature Based Classification Using the Enhanced Fisher
%  Linear Discriminant Model for Face Recognition IEEE IP 11 (2002)467¨C476.
%
function [opts]    =    Create_GaborF (ipts, par)

if mod(par.ke_w,2)~=1 | mod(par.ke_h,2)~=1
    error('The width and height of Gabor kernel should be odd number');
end

[ GaborReal, GaborImg ]  =   MakeAllGaborKernal( par.ke_h, par.ke_w ,par.Gabor_num,par.Kmax, par.f, par.sigma);

radius_w       =    floor(par.ke_w/2);
radius_h       =    floor(par.ke_h/2);
center_w       =    radius_w+1;
center_h       =    radius_h+1;
ker_ener       =    [];

% according the par.raT to select a suitable and accurate size of kernel window
for step  =  1: (radius_w+radius_h)/2
    ratio          =    0;
for i  =  1 :40
    temp_r1 = sum(sum(abs(GaborReal(center_h-radius_h+step:center_h+radius_h-step,center_w-radius_w+step:center_w+radius_w-step,i))));
    temp_r2 = sum(sum(abs(GaborReal(:,:,i))));
    temp_i1 = sum(sum(abs(GaborImg(center_h-radius_h+step:center_h+radius_h-step,center_w-radius_w+step:center_w+radius_w-step,i))));
    temp_i2 = sum(sum(abs(GaborImg(:,:,i))));
    ratio   = ratio + temp_r1/temp_r2/80 + temp_i1/temp_i2/80;
end
   ker_ener = [ker_ener ratio];
   if ratio < par.raT
      step = step - 1;
      break;
   end
end

num     =     size(ipts.dat,3);

for i  =  1: num
    tic
    kel_GR  =  GaborReal(center_h-radius_h+step:center_h+radius_h-step,center_w-radius_w+step:center_w+radius_w-step,:);
    kel_GI  =  GaborImg(center_h-radius_h+step:center_h+radius_h-step,center_w-radius_w+step:center_w+radius_w-step,:);
    [opts.gdat(:,i)] = Gabor_T_Fast1(ipts.dat(:,:,i),par.ds_h,par.ds_w,par.Gabor_num,kel_GR, kel_GI);
    toc
end
