disp('fprintf函数的使用：\n');
for Counter1=1:10 
      
     fprintf('Counter 1 (main) %d of 10\n',Counter1); 
      
     fprintf(' 0 of 10'); 
      
     for Counter2=1:10 
          
         fprintf('%c%c%c%c%c%c%c%c%2d of 10',8,8,8,8,8,8,8,8,Counter2);
         pause(0.1) 
     end 
      
     fprintf('\n') 
      
 end 