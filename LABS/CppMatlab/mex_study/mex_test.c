#include "mex.h" 
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) 
{ 
    double *i;
    i=mxGetPr(prhs[0]);
    if(i[0]==1)
        mexPrintf("hello,world!\n");
    else
        mexPrintf("´ó¼ÒºÃ£¡\n");
} 