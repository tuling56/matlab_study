a{1}='das' ;
a{2}='dasada'; 
tic;
fid=fopen('test.txt','w'); 
for i=1:3 
   fprintf(fid,'%d %s\n',i,num2str(toc));
end 
fclose(fid); 
