% Example: RF for Classification

%% Run RF on Training set
   traindata = textread('satimage_tra.txt');
   x = traindata(:,1:(end-1)); 
   y = traindata(:,end);    
   y(y==7) = 6;  %如果y=7则把其设置为6
   cat = ones(1,size(x,2));
   classwt  = ones(1,length(unique(y)));
   param = [100  3   6   0   1 ...
             1   0   0   0   0 ...
             0   1   0   0   123];
   out = RFClass(param, x, y, cat, classwt);
   printRF(out);
  
% Plot Variable Importance  
  figure;
  bar(out.errimp, 0.1);
  title('Variable Importance');
  xlabel('');
  ylabel('');

% Run RF with training and test set
  testdata = textread('satimage_tes.txt');
  xts = testdata(:,1:(end-1)); 
  yts = testdata(:,end);
  yts(yts==7) = 6;
  param = [50   2   6   0   1 ...
            0   0   0   0   0 ...
            0   1   0   0   123];
  out = RFClass(param, x, y, cat, classwt, xts, yts);
  printRF(out);

% OR,
% Run RF on test set with forest
  testdata = textread('satimage_tes.txt');
  xts = testdata(:,1:(end-1)); 
  yts = testdata(:,end);
  yts(yts==7) = 6;
  forest = out;
  param = out.param;
  out = RFClass(param, xts, yts, forest);
  printRF(out);
  
  clear all;  
  

