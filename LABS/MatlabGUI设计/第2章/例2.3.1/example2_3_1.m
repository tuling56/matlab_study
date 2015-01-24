A=[ 1 2 3;
    4 5 6;
    7 8 9 ];
fid = fopen('a.txt','wt');
fprintf(fid,'%d %d %d \n',A');
fclose(fid);
