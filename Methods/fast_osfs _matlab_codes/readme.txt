


Requirements: 

implementation with Matlab R2012a or above this version


Description:

fast_osfs_d.m: for discrete data

fast_osfs_z.m: for continous data


fast_osfs_z_k: for continouous data,limit the size of the currrently selected feature set to k

fast_osfs_d_k: for discrete data,limit the size of the currrently selected feature set to k

Reference:

Please refer to the following reference for the details of the Fast-OSFS algorithm:

Wu, Xindong, Kui Yu, Wei Ding, Hao Wang, and Xingquan Zhu. "Online feature selection with streaming features." 
Pattern Analysis and Machine Intelligence, IEEE Transactions on 35, no. 5 (2013): 1178-1192.



Note: 

1. The Fast-OSFS algorithm with the matlab codes is much slower than the c++ codes. 
(our paper abover is implemented the Fast-OSFS algorithm in c++ codes.)

2.This package is free foracademic usage. You can run it at your own risk. For other purposes, 
please contact Dr.Kui Yu (ykui713@gmail.com). 