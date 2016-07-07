%softmax generalization logistic loss for multiclass classification

function [loss,gradient] = softmaxloss(labels, preds)
% add by jing: 2015.03.16
% linearInd = sub2ind(matrixSize, rowSub, colSub)
% indices of targets
% labels: start from 1, not 0
% nsample = size(preds,1);
% nclass = length(unique(labels));
% preds = zeros(nsample,nclass);

iy = sub2ind(size(preds),1:size(preds,1),labels)';

% loss
expreds = exp(preds); % n x k
sumexp = sum(expreds,2); % n x 1
loss = sum(1-expreds(iy)./sumexp);

% gradient
gradient = -expreds./repmat(sumexp,1,size(preds,2));
gradient(iy) = 1 + gradient(iy);
