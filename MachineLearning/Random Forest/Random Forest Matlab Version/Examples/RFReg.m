%!
%! Description:
%!
%!   RFReg implements Breiman's random forest algorithm for regression. 
%!   (based on Breiman and Cutler's original Fortran code version 3.3)  
%! 
%! Usage:
%! 
%!   param = [ntree, mtry, ndsize, imp, seed, isavef];
%!
%!   out = RFReg(param, x, y);
%!   out = RFReg(param, x, y, xts, yts);
%!   out = RFReg(param, xts, yts, forest);
%!   PrintRF(out);
%!
%! Arguments:
%!
%!   param    A row-vector for six parameters below.
%!   ntree    Number of trees to grow. This should not be set to too small a number, 
%!            to ensure that every input row gets predicted at least a few times. 
%!   mtry     Number of variables randomly sampled as candidates at each split. 
%!   ndsize   Minimum size of terminal nodes. Setting this number larger causes smaller 
%!            trees to be grown (and thus take less time). 
%!   imp      Should importance of predictors be assessed? (>0 for Yes)
%!   seed     Seed for random number generation.
%!   isavef   If set to 0, the forest will not be retained in the output object; 
%!            set to 1 to retain forest in the output object;
%!            set to 2 to save forest to the file 'rforest.txt' (old file will be overwritten).
%!   x        A m by n data matrix of m samples and n variables containing predictors 
%!            for the training set. 
%!   y        A response column-vector for the training set. 
%!   xts      A p by n data matrix (like x) containing predictors for the test set. 
%!   yts      A response column-vector for the test set. 
%!   
%! Output Values:
%!
%!   type     Object tag.
%!   param    Used parameter vector.
%!   errtr    Error rate for training set.
%!   errts    Error rate for test set.
%!   ypredtr  The predicted values of the input training set based on out-of-bag samples.
%!   ypredts  The predicted values of the input test set based on out-of-bag samples.
%!   imp      Vector of variable importance.
%!   predimp  The matrix of predict importance.
%!   ndbtrees The vector stored the length of each tree. 
%!   trees    The forest in matrix containing  
%!
function [out] = RFReg(param, D1, D2, D3, D4)
%
% Last update on Feb. 25, 2003
% By Ting Wang   Merck & Co.
%
  LF = char(10);
  select = 0;  
  
 errmsg1=['==> Incorrect # of input arguments (must be 3 ~ 5) ...',LF];
 errmsg2=['==> Parameter must be a 1 x 6 vector ...',LF];
 errmsg3=['==> Training data matrix and its response vector must have same # of rows ...',LF];
 errmsg4=['==> Test data matrix and its response vector must have same # of rows ...',LF];
 errmsg5=['==> Response must be a 1-column vector ...',LF];
 errmsg6=['==> Missing data in parameter vector is not allowed ...',LF];
 errmsg7=['==> Missing data in X matrix is not allowed ...',LF];
 errmsg8=['==> Missing data in Y vector is not allowed ...',LF];
 errmsg9=['==> Forest seems to be collasped ...',LF];
errmsg10=['==> Training and Test data matrix must have same # of columns ...',LF];
errmsg11=['==> Test data matrix and its response vector must have same # of rows ...',LF];
errmsg12=['==> Test response must be a 1-column vector  ...',LF];
errmsg13=['==> NDBTREES must be a NTREE x 1 vector  ...',LF];
errmsg14=['==> TREES must be a sum(NDBTREES) x 6 matrix  ...',LF];

  if ~any(nargin==[3 4 5]),    error(errmsg1); return; end;
  if any(size(param)~=[1 6]),  error(errmsg2); return; end;    
    if (nargin==3)         select=1;
    elseif (nargin==5)     select=2;
    else                   select=3; end;
  if size(D1,1)~=size(D2,1)
    if select==1,              error(errmsg3); return; 
    else,                      error(errmsg4); return; end;
  end;
  if size(D2,2)~=1,            error(errmsg5); return; end;
  if any(any(isnan(param))),   error(errmsg6); return; end;
  if any(any(isnan(D1))),      error(errmsg7); return; end;
  if any(any(isnan(D2))),      error(errmsg8); return; end;
    ntree    = param(1);   
    mtry     = param(2);   
    ndsize   = param(3);   
    imp      = param(4);
    seed     = param(5);
    isavef   = param(6);    
  if (isavef==2)
      fn = dir('rforest.txt');
      if length(fn)>0,    dos('del rforest.txt'); end;      
  end;    
        
% Run training set
if select == 1
      mdim    = size(D1,2);
      nsample = size(D1,1);
      ntest   = 1;                           
      irunf   = 0;             
      ntrees  = 1;               
      x    = single(D1');
      y    = single(D2');
      xts  = single(zeros(mdim,1));   
      yts  = single(zeros(1,1));     
      trees    = single(zeros(6,ntrees)); 
      ndbtrees = int32(zeros(1,ntree));        
      nrnodes  = fix(2*(nsample/ndsize)+1); 
    
% Run training set with test set 
elseif select == 2
    if size(D3,2)~=size(D1,2),   error(errmsg10); return; end;
    if size(D3,1)~=size(D4,1),   error(errmsg11); return; end;
    if size(D4,2)~=1,            error(errmsg12); return; end;
      mdim     = size(D1,2);
      nsample  = size(D1,1);
      ntest    = size(D3,1);                           
      irunf    = 0;             
      ntrees   = 1;   
      nrnodes  = fix(2*(nsample/ndsize)+1);       
    x    = single(D1');
    y    = single(D2');
    xts  = single(D3');   
    yts  = single(D4');     
    trees    = single(zeros(6,ntrees)); 
    ndbtrees = int32(zeros(1,ntree));    
    
% Run test data with forest  
elseif select == 3
    fdstr = reshape(char(fieldnames(D3))',1,[]);
    if length([strfind(fdstr,'ndbtrees'),strfind(fdstr,'trees')])<2
        error(errmsg9);     
    end;
    ndbtrees = D3.ndbtrees;
    trees    = D3.trees;
      mdim    = size(D1,2);
      nsample = max(ndbtrees);
      ntest   = size(D1,1);                           
      irunf   = 1;             
      ntrees  = sum(ndbtrees);    
      nrnodes = nsample;     
    if any(size(ndbtrees)~=[ntree 1]),  error(errmsg9); return; end;
    if any(size(trees)~=[ntrees 6]),    error(errmsg9); return; end;      
    x   = single(zeros(nsample,mdim)');
    y   = single(zeros(nsample,1)');
    xts = single(D1');   
    yts = single(D2');     
    ndbtrees = int32(ndbtrees');       
    trees    = single(trees');       
end;
  
% Prepare parameters 
   if imp
       nimp = nsample;    
       mimp = mdim;
   else
       nimp = 1;          
       mimp = 1;
   end;
  cat   = int32(ones(1,mdim)); 
  parameter = int32( ...
    [ mdim;      nsample;  ntest;   ntree;    mtry;    ...
      ndsize;    nimp;     mimp;    nrnodes;  imp;  ...
      seed;      irunf;    isavef;  ntrees ] );
  tic; 
    [yptr, ypred, errtsA, errbA, tgini, errimp, predimp, ...
     nodestatusA, upperA, treemapA, avnodeA, mbestA, ypredA] = ...
  RFRegression(parameter, x, y, cat, xts, yts, trees, ndbtrees);
  toc;

% Setup output object
  disp(['! Collecting outputs. Please wait ...',LF]);
    out = [];
    out.type  = 'Regression';
    out.param = param;
  if (select==1) 
    out.errtr   = double(errbA');
    out.ypredtr = double(yptr');
    out.tgini   = tgini;   
    if (imp)
      out.imp     = errimp;
      out.predimp = predimp;
    end
  elseif (select==2)
    out.errtr   = double(errbA');      
    out.errts   = double(errtsA');
    out.ypredtr = double(yptr');
    out.ypredts = double(ypred');
    out.tgini   = tgini;
    out.ypredA  = double(ypredA');
    if (imp)
      out.imp     = errimp;
      out.predimp = predimp;
    end
  else
    out.errts   = double(errtsA');
    out.ypredts = double(ypred');
  end
  if (isavef==1)
      forest=[]; L=size(nodestatusA,2); 
    for i=1:ntree;
      tree=[ single(nodestatusA(i,:)'), ...
             upperA(i,:)', ...
             single(reshape(treemapA(i,1,:),L,1)), ...
             single(reshape(treemapA(i,2,:),L,1)), ...
             avnodeA(i,:)', ...
             single(mbestA(i,:)') ];
      tree=tree(1:double(ndbtrees(i)),:);
      forest=[forest;tree];
    end
    out.ndbtrees = double(ndbtrees');
    out.trees    = double(forest);
  elseif (isavef==2)       
    out.savef = 'rforest.txt';
  end;
  