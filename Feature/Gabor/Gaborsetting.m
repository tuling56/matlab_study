
% Gaborsetting.m

% scale_w=3;
% scale_h=3;
% Gabor parameter
par.ds_w       =    10;       % the downsample image's width in Gabor
par.ds_h       =    11;       % the downsample image's heigth in Gabor
par.ke_w       =    31;             % Gabor kernel's width
par.ke_h       =    31;             % Gabor kernel's heigth
par.raT        =    0.9;                  % Gabor kernel's energy preseving ratio
par.Kmax       =    pi/2;           % Gabor kernel's para, default(pi/2)
par.f          =    sqrt(2);        % Gabor kernel's para, default(sqrt(2))
par.sigma      =    pi;             % Gabor kernel's para, default(pi or 1.5pi)
par.Gabor_num  =    40;             % Gabor kernel's number, default (5 scales and 8 orientations)

par.lambda_l   =    0.0005;         % parameter of l1_ls in learning
par.lambda_t   =    0.0005;         % parameter of l1_ls in testing
par.dim        =    200;            % the occlusion column dimension; (200 for yaleb) (100 for ar)
