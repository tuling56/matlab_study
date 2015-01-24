% Example: RF for Regressoin

% Run RF on Training set
  TR = textread('boshouse.txt');   
  x = TR(:,2:end); 
  y = TR(:,1);     
  param = [50, fix(size(x,2)/3), 5, 1, 12345, 1];
  out = RFReg(param, x, y);
  printRF(out);
  
  figure;
  subplot 121;      % Plot error rate vs # of run
    plot(out.errtr,'r.'); 
    ylabel('Error MSE_{Training }');
    xlabel('# of Run');
  subplot 122;      % Plot residuals vs predict
    plot(double(out.ypredtr), y-double(out.ypredtr), 'b.'); 
    ylabel('Residual');
    xlabel('Predict_{Training}');
    xmax = axis;
    line([0 xmax(2)],[0 0],'linestyle',':');
  figure;           % Plot variable importance
    bar(double(out.imp), 0.1); 
    title('Variable Importance');
  
% Run RF with training and test set
  x = TR(1:400,2:end);
  y = TR(1:400,1);
  xts = TR(401:end,2:end);
  yts = TR(401:end,1);
  param = [50, fix(size(x,2)/3), 5, 1, 12345, 1];
  out = RFReg(param, x, y, xts, yts);
  printRF(out);
  
% OR,
% Run RF on test set with forest
  forest = out;
  param = out.param;
  out = RFReg(param, xts, yts, forest)
  printRF(out);

  clear all;
  