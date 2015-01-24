#ifndef EM_H
#define EM_H

namespace ker
{
    class cEm
    {
    private:
        int _nVec;     //待分类的向量的个数
        int _nDim;     //向量的维数
        int _nPat;     //类别数
        
        double **_pplfVector;   //待分类的向量
        double **_pplfZ;        //第i个向量属于第j类的概率
        double **_pplfU;        //对于每一个分类的均值向量
        double *_plfPi;         //对于每一个分类的先验概率
        double ***_ppplfDelta;  //对于每一个分类的协方差矩阵
        
        double _lfL;            //存储log likelihood函数值,其值在E-Step里进行计算
                                //最终目标即要使该值最大
        
    public:
        /**
        构造函数，进行内存初始化
        param nVec 待分类的向量数目
        param nDim 待分类的向量维数
        param nPat 将分为多少类
        */
        cEm(int nVec, int nDim, int nPat);
        
        /**
        析构函数，释放所有申请的内存
        */
        virtual ~cEm();
        
        /**
        聚类
        param pplfVector 待聚类的向量，其个数和维数以及类数在构造函数里指定
        */
        void Cluster(double **pplfVector);
        
    private:
        /**
        E-Step
        */
        void Expectation();

        /**
        M-Step
        */
        void Maximization();

        /**
        矩阵求行列式
        param pplfMat 待求行列式的矩阵
        返回值 行列式的值
        */
        double Determinant(double **pplfMat);

        /**
        矩阵求逆
        param pplfMat 待求逆的矩阵
        返回值 double型指针的指针，指向新开辟存储空间，其中保存有原矩阵的逆
        */
        double ** Inverse(double **pplfMat);
        
        /**
        多维高斯分布密度函数
        param plfVec 多维空间中的点坐标，即要求该点上的概率密度
        param plfU 高斯分布的均值向量
        param pplfDelta 高斯分布的协方差矩阵
        返回值 多维空间中对应点的概率密度
        */
        double Gaussian(double *plfVec, double *plfU, double **pplfDelta);
    };
}

#endif
