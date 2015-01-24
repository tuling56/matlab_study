function [c, d] = lpdec(xn, h, g)
%--------------------------------------------------------------------------
% Laplacian pyramid decomposition of image.
% Syntax     : [c, d] = lpdec(x, h, g)
% 
% Input
%       xn   : 2-Dimension signal (image)
%       h    : filter for the Laplacian pyramid
%       g    : filter for the Laplacian pyramid
% Output
%       c    : coarse image at half size
%       d    : detail image at full size
% 
% See also   : lprec, seperate_2d_filter, imextend 
%--------------------------------------------------------------------------
extmode = 'per';
flag = 0;
shift = flag * [1,1];

xlow = separate_2d_filter(xn, h, h, extmode, shift);
c = xlow(1:2:end, 1:2:end);

flag = mod(length(g)+1, 2);
shift = flag * [1,1];

xlow = zeros(size(xn));
xlow(1:2:end, 1:2:end) = c;
xlow_interpolate = separate_2d_filter(xlow, g, g, extmode, shift);

d = xn - xlow_interpolate;
