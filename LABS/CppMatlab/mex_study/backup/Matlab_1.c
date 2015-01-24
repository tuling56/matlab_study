#include "mex.h"
//计算过程
void hilb(double *y,int n)
{
        int i,j;
        for(i=0;i<n;i++)
               for(j=0;j<n;j++)
                      *(y+j+i*n)=1/((double)i+(double)j+1);
}
//接口过程
void mexFunction(int nlhs,mxArray *plhs[],int nrhs,const mxArray *prhs[])
{
        double x,*y;
        int n;
        if (nrhs!=1)
               mexErrMsgTxt("One inputs required.");
        if (nlhs != 1) 
               mexErrMsgTxt("One output required.");
        if (!mxIsDouble(prhs[0])||mxGetN(prhs[0])*mxGetM(prhs[0])!=1)
               mexErrMsgTxt("Input must be scalars.");
        x=mxGetScalar(prhs[0]);
        plhs[0]=mxCreateDoubleMatrix(x,x,mxREAL);
        n=mxGetM(plhs[0]);
        y=mxGetPr(plhs[0]);
        hilb(y,n);
}    
