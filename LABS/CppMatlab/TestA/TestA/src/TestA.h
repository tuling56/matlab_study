/*
 * MATLAB Compiler: 4.18 (R2012b)
 * Date: Wed Apr 23 19:29:20 2014
 * Arguments: "-B" "macro_default" "-W" "lib:TestA" "-T" "link:lib" "-d"
 * "E:\360‘∆≈Ã\Git\Matlab_Github\Matlab—ßœ∞¥˙¬Î\TestA\TestA\src" "-w"
 * "enable:specified_file_mismatch" "-w" "enable:repeated_file" "-w"
 * "enable:switch_ignored" "-w" "enable:missing_lib_sentinel" "-w"
 * "enable:demo_license" "-v"
 * "E:\360‘∆≈Ã\Git\Matlab_Github\Matlab—ßœ∞¥˙¬Î\TestA\TestA.m" 
 */

#ifndef __TestA_h
#define __TestA_h 1

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

#ifdef EXPORTING_TestA
#define PUBLIC_TestA_C_API __global
#else
#define PUBLIC_TestA_C_API /* No import statement needed. */
#endif

#define LIB_TestA_C_API PUBLIC_TestA_C_API

#elif defined(_HPUX_SOURCE)

#ifdef EXPORTING_TestA
#define PUBLIC_TestA_C_API __declspec(dllexport)
#else
#define PUBLIC_TestA_C_API __declspec(dllimport)
#endif

#define LIB_TestA_C_API PUBLIC_TestA_C_API


#else

#define LIB_TestA_C_API

#endif

/* This symbol is defined in shared libraries. Define it here
 * (to nothing) in case this isn't a shared library. 
 */
#ifndef LIB_TestA_C_API 
#define LIB_TestA_C_API /* No special import/export declaration */
#endif

extern LIB_TestA_C_API 
bool MW_CALL_CONV TestAInitializeWithHandlers(
       mclOutputHandlerFcn error_handler, 
       mclOutputHandlerFcn print_handler);

extern LIB_TestA_C_API 
bool MW_CALL_CONV TestAInitialize(void);

extern LIB_TestA_C_API 
void MW_CALL_CONV TestATerminate(void);



extern LIB_TestA_C_API 
void MW_CALL_CONV TestAPrintStackTrace(void);

extern LIB_TestA_C_API 
bool MW_CALL_CONV mlxTestA(int nlhs, mxArray *plhs[], int nrhs, mxArray *prhs[]);



extern LIB_TestA_C_API bool MW_CALL_CONV mlfTestA(int nargout, mxArray** y, mxArray* x);

#ifdef __cplusplus
}
#endif
#endif
