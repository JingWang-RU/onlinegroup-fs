%softmax generalization logistic loss for multiclass classification

function [loss,gradient] = MCL(preds,labels)

% indices of targets
iy = sub2ind(size(preds),1:size(preds,1),labels')';

% loss
expreds = exp(preds); % n x k
sumexp = sum(expreds,2); % n x 1
loss = sum(1-expreds(iy)./sumexp);

% gradient
gradient = -expreds./repmat(sumexp,1,size(preds,2));
gradient(iy) = 1 + gradient(iy);
