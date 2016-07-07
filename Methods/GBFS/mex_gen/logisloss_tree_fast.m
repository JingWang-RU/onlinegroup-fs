function [loss,grad]=logisloss_tree_fast(H,xtr,ytr);
	
	% INPUT:
	% xtr ntraxd matrix 
	% ytr ntrax1 matrix (labels are [1:k])
	% xtv nvalxd matrix 
	% ytv nvalx1 matrix (each entry is a label)
	%
	% OUTPUTS:
	% 
	% loss = the total loss 
	% grad = the gradient at current H 
	
	sig=@(z) 1./(1+exp(-z));
	
	[ntra,d]=size(xtr);
	
	sigH = sig(H);
	loss = -sum(ytr.*log(sigH) + (1-ytr).*log(1-sigH));
	grad = ytr - sigH;
	