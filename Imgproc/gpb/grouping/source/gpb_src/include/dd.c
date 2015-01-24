#include"mex.h" 
long squar(int a) 
{ 
   long out ; 
   out = a*a ; 
   return out ; 
} 
void mexfunction( int nlhs , mxArray *plhs[], 
                   int nrhs ,const mxArray *prhs[] ) 
{ 
    long *out ; 
    int n ; 
    out = mxGetPr(plhs[0]); 
    n = mxGetScalar(prhs[0]); 
  
    *out= square( n );    
}