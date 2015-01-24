function yn = imextend(xn, urow, drow, lcol, rcol, extmode)
%--------------------------------------------------------------------------
% Making two dimenstion extension of image.
% Syntax        : yn = imextend(xn, urow, drow, lcol, rcol, extmode)
% 
% Input
%       xn      : 2-Dimension signal (image)
%       urow    : extension amount for up direction of row
%       drow    : extension amount for down direction of row
%       lcol    : extension amount for left direction of column 
%       rcol    : extension amount for right direction of column 
%       extmode : extension mode for input image :
%                 'per' : periodized extension in both direction
% Output
%       yn      : extended image
%--------------------------------------------------------------------------
[M,N] = size(xn);

switch extmode
    case 'per'
        In = indices(M, urow, drow);
        yn = xn(In, :);
        In = indices(N, lcol, rcol);
        yn = yn(:, In);

    otherwise
	error('Invalid input for extension mode')
end	

%--------------------------------------------------------------------------
%                               subfunction
%--------------------------------------------------------------------------
function In = indices(mid, side1, side2)

In = [mid-side1+1:mid, 1:mid, 1:side2];

if (mid < side1) || (mid < side2)
    In = mod(In, mid);
    In(I==0) = mid;
end
