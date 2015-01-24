function xn = lprec(c, d, h, g)
%--------------------------------------------------------------------------
% Laplacian pyramid reconstruction of image.
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

xhig = separate_2d_filter(d, h, h, extmode, shift);
xhig = xhig(1:2:end, 1:2:end);

xlow = zeros(size(d));
xlow(1:2:end, 1:2:end) = c - xhig;

flag = mod(length(g)+1, 2);
shift = flag * [1,1];

xlow_interpolate = separate_2d_filter(xlow, g, g, extmode, shift);

xn = d + xlow_interpolate;
