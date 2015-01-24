/*
 * MATLAB Compiler: 4.18 (R2012b)
 * Date: Fri Apr 25 21:02:51 2014
 * Arguments: "-B" "macro_default" "-B" "csharedlib:matlabimportdll" "-W"
 * "lib:matlabimportdll" "-T" "link:lib" "matlabimportdll.m" 
 */

#ifndef __matlabimportdll_h
#define __matlabimportdll_h 1

#if defined(__cplusplus) && !defined(mclmcrrt_h) && defined(__linux__)
#  pragma implementation "mclmcrrt.h"
#endif
#include "mclmcrrt.h"
#ifdef __cplusplus
extern "C" {
#endif

#if defined(__SUNPRO_CC)
/* Solaris shared libraries use __global, rather than mapfiles
 * to define the API exported from a shared library. __global is
 * only necessary when building the library -- files including
 * this header file to use the library do not need the __global
 * declaration; hence the EXPORTING_<library> logic.
 */

#ifdef EXPORTING_matlabimportdll
#define PUBLIC_matlabimportdll_C_API __global
#else
#define PUBLIC_matlabimportdll_C_API /* No import statement needed. */
#endif

#define LIB_matlabimportdll_C_API PUBLIC_matlabimportdll_C_API

#elif defined(_HPUX_SOURCE)

#ifdef EXPORTING_matlabimportdll
#define PUBLIC_matlabimportdll_C_API __declspec(dllexport)
#else
#define PUBLIC_matlabimportdll_C_API __declspec(dllimport)
#endif

#define LIB_matlabimportdll_C_API PUBLIC_matlabimportdll_C_API


#else

#define LIB_matlabimportdll_C_API

#endif

/* This symbol is defined in shared libraries. Define it here
 * (to nothing) in case this isn't a shared library. 
 */
#ifndef LIB_matlabimportdll_C_API 
#define LIB_matlabimportdll_C_API /* No special import/export declaration */
#endif

extern LIB_matlabimportdll_C_API 
bool MW_CALL_CONV matlabimportdllInitializeWithHandlers(
       mclOutputHandlerFcn error_handler, 
       mclOutputHandlerFcn print_handler);

extern LIB_matlabimportdll_C_API 
bool MW_CALL_CONV matlabimportdllInitialize(void);

extern LIB_matlabimportdll_C_API 
void MW_CALL_CONV matlabimportdllTerminate(void);



extern LIB_matlabimportdll_C_API 
void MW_CALL_CONV matlabimportdllPrintStackTrace(void);

extern LIB_matlabimportdll_C_API 
bool MW_CALL_CONV mlxMatlabimportdll(int nlhs, mxArray *plhs[], int nrhs, mxArray 
                                     *prhs[]);



extern LIB_matlabimportdll_C_API bool MW_CALL_CONV mlfMatlabimportdll();

#ifdef __cplusplus
}
#endif
#endif
