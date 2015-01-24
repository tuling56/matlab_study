#include "em.h"
#include "memory.h"
#include "stdlib.h"
#include "stdio.h"
#include "math.h"
#include "time.h"

namespace ker
{
    #define PI 3.1415926
    
    //一个很小的数，用来解决协方差矩阵行列式为0以及高斯密度分布函数为0的问题
    #define CONST_E 0.000000000001
    
    cEm::cEm(int nVec, int nDim, int nPat)
    {
        _nVec = nVec;
        _nDim = nDim;
        _nPat = nPat;

        //_pplfZ[i][j]表示第i个向量属于第j类的概率,初始化为0
        _pplfZ = new double *[_nVec];
        for (int i = 0; i < _nVec; i++)
        {
            _pplfZ[i] = new double[_nPat];
            memset(_pplfZ[i], 0, sizeof(double) * _nPat);
        }
        
        //_pplfU[i]表示第i类的均值向量，其初始化的值有可能导致陷入局部极值
        //因此其初始化的值根据待分类数据来给出
        _pplfU = new double *[_nPat];
        for (int i = 0; i < _nPat; i++)
        {
            _pplfU[i] = new double[_nDim];
            //for (int j = 0; j < _nDim; j++) _pplfU[i][j] = i * 2;
        }
        
        //_ppplfDelta[i]表示第i类的协方差矩阵,并把协方差矩阵初始化成单位阵
        _ppplfDelta = new double **[_nPat];
        for (int i = 0; i < _nPat; i++)
        {
            _ppplfDelta[i] = new double *[_nDim];
            for (int j = 0; j < _nDim; j++)
            {
                _ppplfDelta[i][j] = new double[_nDim];
                memset(_ppplfDelta[i][j], 0, sizeof(double) * _nDim);
                _ppplfDelta[i][j][j] = 1;
            }
        }
        
        //_plfPi[i]表示第i类的先验概率,初始化为1 / _nPat
        _plfPi = new double [_nPat];
        for (int i = 0; i < _nPat; i++) _plfPi[i] = 1.0 / _nPat;
    }

    cEm::~cEm()
    {
        for (int i = 0; i < _nVec; i++) delete []_pplfZ[i];
        delete []_pplfZ;

        for (int i = 0; i < _nPat; i++) delete[]_pplfU[i];
        delete []_pplfU;
        
        for (int i = 0; i < _nPat; i++)
        {
            for (int j = 0; j < _nDim; j++) delete[]_ppplfDelta[i][j];
            delete []_ppplfDelta[i];
        }
        delete []_ppplfDelta;
        delete []_plfPi;
    }
    
    double **cEm::Inverse(double **pplfMatSrc)
    {
        //复制原矩阵
        double **pplfMat = new double *[_nDim];
        for (int i = 0; i < _nDim; i++)
        {
            pplfMat[i] = new double [_nDim];
            memcpy(pplfMat[i], pplfMatSrc[i], sizeof(double) * _nDim);
        }
        
        //创建一个单位阵
        double **pplfI = new double *[_nDim];
        for (int i = 0; i < _nDim; i++)
        {
            pplfI[i] = new double [_nDim];
            memset(pplfI[i], 0, sizeof(double) * _nDim);
            pplfI[i][i] = 1;
        }
        
        //Gaussian消元法求逆矩阵--正向消元
        for (int i = 0; i < _nDim; i++)
        {
            double lfTmp = pplfMat[i][i];
            for (int j = 0; j < _nDim; j++)
            {
                pplfMat[i][j] /= lfTmp;
                pplfI[i][j] /= lfTmp;
            }
            
            for (int j = i + 1; j < _nDim; j++)
            {
                double lfTmp = -pplfMat[j][i];
                for (int k = 0; k < _nDim; k++)
                {
                    pplfMat[j][k] += lfTmp * pplfMat[i][k];
                    pplfI[j][k] += lfTmp * pplfI[i][k];
                }
            }
        }
        
        //Gaussian消元法求逆矩阵--逆向消元
        for (int i = _nDim - 1; i >= 0; i--)
            for (int j = i - 1; j >= 0; j--)
            {
                double lfTmp = -pplfMat[j][i];
                for (int k = 0; k < _nDim; k++)
                {
                    pplfMat[j][k] += pplfMat[i][k] * lfTmp;
                    pplfI[j][k] += pplfI[i][k] * lfTmp;
                }
            }

        //销毁临时空间
        for (int i = 0; i < _nDim; i++) delete []pplfMat[i];
        delete []pplfMat;
        
        return pplfI;
    }
    
    double cEm::Determinant(double **pplfMatSrc)
    {
        //复制原矩阵
        double **pplfMat = new double *[_nDim];
        for (int i = 0; i < _nDim; i++)
        {
            pplfMat[i] = new double [_nDim];
            memcpy(pplfMat[i], pplfMatSrc[i], sizeof(double) * _nDim);
        }
        
        //Gaussian消元法--得到对角形式
        for (int i = 0; i < _nDim; i++)
        {
            for (int j = i + 1; j < _nDim; j++)
            {
                double lfTmp = -pplfMat[j][i] / pplfMat[i][i];
                for (int k = 0; k < _nDim; k++) pplfMat[j][k] += lfTmp * pplfMat[i][k];
            }
        }
        
        //计算对角线乘积
        double lfRs = 1;
        for (int i = 0; i < _nDim; i++) lfRs *= pplfMat[i][i];
            
        //销毁临时空间
        for (int i = 0; i < _nDim; i++) delete []pplfMat[i];
        delete []pplfMat;
            
        return lfRs;
    }
    
    double cEm::Gaussian(double *plfVec, double *plfU, double **pplfDelta)
    {
        //整个函数是求多维高斯分布密度函数
        
        double *plfTmp1 = new double[_nDim];
        double *plfTmp2 = new double[_nDim];
        
        for (int i = 0; i < _nDim; i++) plfTmp1[i] = plfVec[i] - plfU[i];
        memset(plfTmp2, 0, sizeof(double) * _nDim);
        
        double **pplfInvDelta = Inverse(pplfDelta);

        for (int i = 0; i < _nDim; i++)
            for (int j = 0; j < _nDim; j++)
                plfTmp2[i] += plfTmp1[j] * pplfInvDelta[j][i];
                
        double lfTmp1 = 0;
        for (int i = 0; i < _nDim; i++)
            lfTmp1 += plfTmp2[i] * plfTmp1[i];
        lfTmp1 /= -2;
        lfTmp1 = exp(lfTmp1);
        
        double lfDelta = Determinant(pplfDelta);
        double lfTmp2 = 1 / sqrt (pow(2 * PI, _nDim) * lfDelta) * lfTmp1;
        
        for (int i = 0; i < _nDim; i++) delete []pplfInvDelta[i];
        delete []pplfInvDelta;
        delete []plfTmp1;
        delete []plfTmp2;

        if (lfTmp2 < CONST_E) lfTmp2 = CONST_E;
        return lfTmp2;
    }

    void cEm::Expectation()
    {
        //E-Step
        _lfL = 0;
        for (int i = 0; i < _nVec; i++)
        {
            double lfSum = 0;//用于计算likelihood
            for (int j = 0; j < _nPat; j++)
            {
                double lfTmp = 0;
                for (int l = 0; l < _nPat; l++)
                {
                    double lfG = Gaussian(_pplfVector[i], _pplfU[l], _ppplfDelta[l]);
                    lfTmp += _plfPi[l] * lfG;
                }
                double lfG = Gaussian(_pplfVector[i], _pplfU[j], _ppplfDelta[j]);
                _pplfZ[i][j] = _plfPi[j] * lfG / lfTmp;
                lfSum += _plfPi[j] * lfG;
            }
            _lfL += log(lfSum);
        }
    }
    
    void cEm::Maximization()
    {
        //M-Step
        for (int j = 0; j < _nPat; j++)
        {
            double lfTmp1 = 0;
            for (int i = 0; i < _nVec; i++) lfTmp1 += _pplfZ[i][j];
            
            //最大化步骤--求_pplfU[j]
            memset(_pplfU[j], 0, sizeof(double) * _nDim);
            for (int i = 0; i < _nVec; i++)
                for (int k = 0; k < _nDim; k++)
                    _pplfU[j][k] += _pplfZ[i][j] * _pplfVector[i][k];
            for (int k = 0; k < _nDim; k++) _pplfU[j][k] /= lfTmp1;

            //最大化步骤--求_ppplfDelta[j]
            for (int i = 0; i < _nDim; i++)
                memset(_ppplfDelta[j][i], 0, sizeof(double) * _nDim);
            for (int i = 0; i < _nVec; i++)
            {
                double *plfTmp = new double[_nDim];
                for (int a = 0; a < _nDim; a++) plfTmp[a] = _pplfVector[i][a] - _pplfU[j][a];
                
                //????????????????????????????????????????????????????????????
                //这一步中只能忽略掉协方差，只考虑本身方差，为什么？跟公式不和!
                for (int a = 0; a < _nDim; a++)
                    //for (int b = 0; b <= _nDim; b++)
                        _ppplfDelta[j][a][a] += _pplfZ[i][j] * plfTmp[a] * plfTmp[a];
                delete[]plfTmp;
            }
            for (int a = 0; a < _nDim; a++)
                //for (int b = 0; b < _nDim; b++)
                    //????????????????????????????????????????????????????????????
                {
                    _ppplfDelta[j][a][a] = _ppplfDelta[j][a][a] / lfTmp1;
                    _ppplfDelta[j][a][a] += CONST_E;
                }
                    
            //最大化步骤--求_plfPi[j]
            _plfPi[j] = lfTmp1 / _nVec;
        }
    }
        
    void cEm::Cluster(double **pplfVector)
    {
        _pplfVector = pplfVector;

        //初始化聚类中心，即均值数据
        /*double *plfMax = new double[_nDim];
        double *plfMin = new double[_nDim];
        
        memcpy(plfMax, _pplfVector[0], sizeof(double) * _nDim);
        memcpy(plfMin, _pplfVector[0], sizeof(double) * _nDim);
        for (int i = 1; i < _nVec; i++)
            for (int j = 0; j < _nDim; j++)
            {
                if (_pplfVector[i][j] < plfMin[j]) plfMin[j] = _pplfVector[i][j];
                if (_pplfVector[i][j] > plfMax[j]) plfMax[j] = _pplfVector[i][j];
            }
        */
        srand((unsigned)time(NULL));
        rand();
        
        bool *bSign = new bool[_nVec];
        memset(bSign, false, sizeof(bool) * _nVec);
        
        for (int i = 0; i < _nPat; i++)
        {
            int nPt;
            do {
                nPt = (int)(((double)rand() / (double)RAND_MAX) * (_nVec - 0.1));
            }while (bSign[nPt]);
            bSign[nPt] = true;
            memcpy(_pplfU[i], _pplfVector[nPt], sizeof(double) * _nDim);
        }
        delete []bSign;
        //delete []plfMax;
        //delete []plfMin;
        
        printf("初始聚类中心\n");
        for (int i = 0; i < _nPat; i++)
        {
            printf("pattern %d mean", i);
            for (int j = 0; j < _nDim; j++) printf("%12.5lf", _pplfU[i][j]);
            printf("\n");
        }
        printf("\n");
        
        //下面开始E-M过程
        
        Expectation();
        Maximization();
            
        int nCount = 0;
        double lfL_bf;
        do
        {
            lfL_bf = _lfL;
            nCount++;
            Expectation();
            Maximization();

            printf("%d%12.5lf\n", nCount, _lfL);
        } while(fabs(_lfL - lfL_bf) > CONST_E);
        
        for (int i = 0; i < _nVec; i++)
        {
            for (int j = 0; j < _nPat; j++) printf("%12.5lf", _pplfZ[i][j]);
            printf("\n");
        }
        printf("\n");
        for (int i = 0; i < _nPat; i++)
        {
            printf("pattern %d mean", i);
            for (int j = 0; j < _nDim; j++) printf("%12.5lf", _pplfU[i][j]);
            printf("\n");
        }
        printf("\n");
        for (int i = 0; i < _nPat; i++)
        {
            printf("pattern %d fangcha\n", i);
            for (int j = 0; j < _nDim; j++)
            {
                for (int a = 0; a < _nDim; a++)
                    printf("%12.5lf", _ppplfDelta[i][j][a]);
                printf("\n");
            }
            printf("\n");
        }
        printf("\n");
    }
}
