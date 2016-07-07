% this function is to make the GBFS to a package, and used by onlinefeature
% selection
function [feaIdx] = GBFS_jing(train_x, train_y, param_one, param_two)
% input data: 
% xtr: ntr*m; % training data, seperate into training and validation
% ytr: ntr*1; 
% xte: nte*m; % testing data
% yte: nte*1;
% addpath to the CART tree generator, and make
% addpath('mex_gen');
% cd('./methods/GBFS/GBFS/mex_gen');
% make
% cd ..

% load in data (PCMAC data set)
xtr = train_x;
ytr = train_y;

% 80-20 split to generate validation
rand('seed',1);
perc = 0.8; %the smaller, tst_prec is worser
itr = ismember(1:length(ytr),randsample(1:length(ytr),ceil(perc*length(ytr))));
xtv = xtr(~itr,:);
ytv = ytr(~itr);
xtr = xtr(itr,:);
ytr = ytr(itr);

% generate GBFS trees, with lambda = 1;
lambda = param_two;%1e-5;
sparsity = ones(1,size(xtr,2)); % same sparsity for every feature (no pre-defined sparsity patterns)
% feat_ind: size of feature space, 1 selected, 0 not selected
[feat_ind] = GBFS(xtr,ytr,xtv,ytv,sparsity,lambda);

feaIdx = find(feat_ind~=0);


