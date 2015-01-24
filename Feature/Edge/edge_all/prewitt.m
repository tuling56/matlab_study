%%%%prewittËã×Ó
function[ans]=prewitt(I);
ans=zeros(size(I));
Isize=size(I);
I=double(I);
fx=0;
fy=0;
for i=2:Isize(1)-1
    for j=2:Isize(2)-1
        fx=(I(i-1,j+1)+I(i,j+1)+I(i+1,j+1))-(I(i-1,j-1)+I(i,j-1)+I(i+1,j-1));
        fy=(I(i+1,j-1)+I(i+1,j)+I(i+1,j+1))-(I(i-1,j-1)+I(i-1,j)+I(i-1,j+1));
        ans(i,j)=sqrt(fx*fx+fy*fy);
        if ans(i,j)>130
            ans(i,j)=255;
        else
            ans(i,j)=0;
        end
    end
end
ans=uint8(ans);