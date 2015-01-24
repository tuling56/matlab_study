clear all;
for m=1:k
    for n=1:k
        if m==n
            a(m,n)=2;
        elseif abs(m-n)==2
            a(m,n)=1;
        else
            a(m,n)=0;
        end
    end
end
a
