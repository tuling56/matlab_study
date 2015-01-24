function yn = separate_2d_filter(xn, fcol, frow, extmode, shift)
%--------------------------------------------------------------------------
% Making two dimenstion separable filtering of image.
% Syntax        : yn = separate_2d_filter(xn, fcol, frow, extmode, shift)
% 
% Input
%       xn      : 2-Dimension signal (image)
%       fcol    : 1-D filter in row dimension
%       frow    : 1-D filter in column dimension
%       extmode : extension mode for input image
%       shift   : specify the window over which the convolution occurs
% Output
%       yn      : filtered image of the same size as the input image
% 
% See also      : imextend
%--------------------------------------------------------------------------
fcol = fcol(:)';
frow = frow(:)';
Lc = (length(fcol)-1) / 2;
Lr = (length(frow)-1) / 2;

yn = imextend(xn, floor(Lc)+shift(1), ceil(Lc)-shift(1), ...
              floor(Lr)+shift(2), ceil(Lr)-shift(2), extmode);

yn = conv2(fcol, frow, yn, 'valid');
