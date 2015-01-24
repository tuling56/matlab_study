#include "stdio.h"
#include "em.h"

using namespace ker;

int main()
{
    int nVec = 9;
    int nDim = 2;
    int nPat = 3;
    cEm em(nVec, nDim, nPat);
    double **a = new double*[nVec];
    for (int i = 0; i < nVec; i++)
    {
        a[i] = new double[nDim];
    }
    a[0][0] = 0; a[0][1] = 5;
    a[1][0] = 0; a[1][1] = 6;
    a[2][0] = 1; a[2][1] = 6;
    a[3][0] = 2; a[3][1] = 4;
    a[4][0] = 3; a[4][1] = 3;
    a[5][0] = 3; a[5][1] = 4;
    a[6][0] = 4; a[6][1] = 1;
    a[7][0] = 5; a[7][1] = 1;
    a[8][0] = 5; a[8][1] = 2;

    for (int i = 0; i < nVec; i++)
    {
        for (int j = 0; j < nDim; j++)
            printf("%8.5lf", a[i][j]);
        printf("\n");
    }

    em.Cluster(a);	
    
    for (int i = 0; i < nVec; i++) delete []a[i];
    delete[]a;
	return 0;
}
