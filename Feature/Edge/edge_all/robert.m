%%%%RobertËã×Ó
function[ans]=robert(I);
ans=zeros(size(I));
Isize=size(I);

for i=1:Isize(1)-1
    for j=1:Isize(2)-1
        ans(i,j)=abs(I(i,j)-I(i+1,j))+abs(I(i,j)-I(i,j+1));
        
        if ans(i,j)>30
            ans(i,j)=255;
        else
            ans(i,j)=0;
        end
    end
end
