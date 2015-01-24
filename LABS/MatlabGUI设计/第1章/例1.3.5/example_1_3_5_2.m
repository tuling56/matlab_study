a = 'abcdefgmatmatlablabmatlab';
b = 'matlab';
k = 1;
na = length(a);
nb = length(b);
for i = 1 : (na - nb + 1)
    if strcmp(a(i : nb + i - 1),b)
        n(k) = i;
        k = k + 1;
    end
end
n
