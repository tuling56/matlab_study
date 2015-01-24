%%%%marrËã×Ó
function[ans]=marr(I);
ans=zeros(size(I));
Isize=size(I);
I=double(I);
fx=0;
fy=0;
for i=3:Isize(1)-2
    for j=3:Isize(2)-2
        ans(i,j)=16*I(i,j)-2*I(i-1,j)-2*I(i+1,j)-2*I(i,j-1)-2*I(i,j+1)-I(i-1,j-1)-I(i-1,j+1)-I(i+1,j-1)-I(i+1,j+1)-I(i-2,j)-I(i+2,j)-I(i,j-2)-I(i,j+2);
        if ans(i,j)>-120
            ans(i,j)=0;
        else
            ans(i,j)=255;
        end
    end
end
ans=uint8(ans);