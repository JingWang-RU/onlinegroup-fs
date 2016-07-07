// matlab code for GreedyMiser
// 
// Zhixiang (Eddie) Xu, Kilian Q. Weinberger, Olivier Chapelle
// The Greedy Miser: Learning Under Test-time Budget
// Proc. of 29th Intl. Conf. on Machine Learning (ICML), Edinburgh, 2012


#include <mex.h>
#include <math.h>
#include "matrix.h"
#include <string.h>
#include <time.h>
#include <queue>
#include <algorithm>
using namespace std;

// bool comparison (const pair<double, int>&, const pair<double, int>&);

void mexFunction(int nlhs, mxArray *plhs[],
                 int nrhs, const mxArray *prhs[])
{
  double *X, *Trees, *preds;
  double lr;
  int depth, interval;
  
  int d, ntst, ntrees;
  int treelen=0, index;

  int ii, jj, dd;
  /* first get the input data */
  /* input are X (nxd), Trees (2^0+2^1+...2^(depth-1))xntrees, depth, learningrate, interval */
  /* return predictions, nx1 */
  	
  X = mxGetPr(prhs[0]);
  ntst = mxGetM(prhs[0]);
  d = mxGetN(prhs[0]);
  Trees = mxGetPr(prhs[1]);
  depth = (int)(*(mxGetPr(prhs[2])));
  lr = (double)(*(mxGetPr(prhs[3])));
  interval = (int)(*(mxGetPr(prhs[4])));
  
  // individual tree length
  for (ii=0; ii<depth; ii++) {
  	  treelen += pow(2,ii);	
  }
  ntrees = (int)(mxGetM(prhs[1])/treelen);
  
  int totalpreds = 1;
  if (interval!=0) {
	  totalpreds = ntrees/interval;
  }
  
  /* Create output matrix */
  plhs[0] = mxCreateDoubleMatrix(ntst,totalpreds,mxREAL); 
  preds = mxGetPr(plhs[0]);
  memset(preds,0,sizeof(double)*ntst*totalpreds);
  
  
  int intind = 0;
  // evaluate trees
  for (ii=0; ii<ntrees; ii++) {
	  if (interval!=0 && ii%interval==0 && ii>0) {
		  intind++;
	  }
	  int zxiitreelen = ii*treelen;
	  int oxiitreelen = ntrees*treelen+ii*treelen;
	  int txiitreelen = ntrees*treelen*3+ii*treelen;
	  for (jj=0; jj<ntst; jj++) {
		  // evaluate each tree
		  int offset = 1;
		  for (dd=0; dd<depth-1; dd++) {
			  // feature index
			  index = Trees[zxiitreelen+offset-1]-1;
			  if (X[ntst*index+jj] < Trees[oxiitreelen+offset-1]) {
				  offset = offset*2;
			  }
			  else {
				  offset = offset*2+1;
			  }
			  // mexPrintf("find: %d\n",index);
		  }
		  // prediction from leaf
		  if (interval!=0) {
			  // mexPrintf("intind*ntst+jj: %d\n",intind*ntst+jj);
		  	  preds[intind*ntst+jj] += lr*Trees[txiitreelen+offset-1];
		  }
		  else {
		  	  preds[jj] += lr*Trees[txiitreelen+offset-1];		
		  }
	  }
  }
}


	
