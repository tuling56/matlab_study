a = [1 : 9];
b = a;
for i = 1 : 9
    for j = 1 : i
        fprintf(1,'%d¡Á%d=%2d  ',b(j),a(i),b(j)*a(i));
    end
fprintf(1,'\n');  
end
