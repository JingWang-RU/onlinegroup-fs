function flist = Lars(D, X, no_para_1, no_para_2)
% Input:
% D: n*m, feature representation, n is the number of samples, m is the dimension of feature space
% X: n*1, label, n is the number of samples
% Output:
% flist: index of selected features
addpath('./spams-matlab/build');
randn('seed',0);
fprintf('test mexLasso\n');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Decomposition of a large number of signals
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% X=randn(100,1);
% X=X./repmat(sqrt(sum(X.^2)),[size(X,1) 1]);
% D=randn(100,200);
% D=D./repmat(sqrt(sum(D.^2)),[size(D,1) 1]);

% parameter of the optimization procedure are chosen
% param.L=20; % not more than 20 non-zeros coefficients (default: min(size(D,1),size(D,2)))
param.lambda=no_para_1; % 0.15 not more than 20 non-zeros coefficients
param.numThreads=-1; % number of processors/cores to use; the default choice is -1
                     % and uses all the cores of the machine
param.mode=2;        % penalized formulation

% tic
alpha=mexLasso(X,D,param);
% t=toc
flist = find(alpha~=0);
% fprintf('%f signals processed per second\n',size(X,2)/t);
