//mex_test.cpp
#include "mex.h" //使用mexw文件必须包含的头文件

//函数
void timestwo(double y[],double x[])
{
	y[0]=2.0*x[0];
}

//接口
/*参数说明：例如a=add(b,c)
 *nlhs:调用函数语句左手面的变量数
 *plhs:是一个数组，其内容为指针，该指针指向数据类型mxArray。因为现在左手面只有一个变量，即该数组只有一个指针，plhs[0]指向的结果会赋值给a。
 *nrhs:调用函数语句左手面的变量数(其实就是函数参数数目)
 *prhs：右手面有两个自变量，即该数组有两个指针，prhs[0]指向了b，prhs[1]指向了c。要注意prhs是const的指针数组，即不能改变其指向内容。
 */
void mexFunction(int nlhs,mxArray*plhs[],int nrhs,const mxArray*prhs[])
{
	double *x,*y;
	int mrows,nrows;
	if(nrhs!=1)
		mexErrMsgTxt("One input required");
	else if(nlhs>1)
		mexErrMsgTxt("Too many output arguments");

	 mrows=mxGetM(prhs[0]);
	 nrows=mxGetN(prhs[0]);
	 if(!mxIsDouble(prhs[0])||mxIsComplex(prhs[0])||!(mrows==1&&nrows==1))
		 mexErrMsgTxt("Input must be a noncomplex scalar double");
	 plhs[0]=mxCreateDoubleMatrix(mrows,nrows,mxREAL);
	 x=mxGetPr(prhs[0]);
	 y=mxGetPr(plhs[0]);
	 timestwo(y,x);

}

