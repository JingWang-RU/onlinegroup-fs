function [fea_ind, SF] = Spec(X,Y)

%   Pram - the prameter of the algorithm
%   Pram.style - 1: unsupervised feature selection 2: supervised feature
%                         selection
%   Pram.expLam - the exp order for the eigenvalue
%   Pram.function - 1:f'Lf; 2:using all eigenvalue except the first one; 3:
%                             using the first k eigenvalues. (In this case
%                             the wieght the bigger the better.

Pram.style = 1;
Pram.expLam = 1;%1, 2
Pram.function = 2;
W = constructW(X);
 [ fea_ind, SF ] = fsSpectrum( W, X, Y, Pram );