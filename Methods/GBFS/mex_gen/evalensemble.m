function [p] = evalensemble(X,ensemble,p)
	% extract from ensemble
	learningrates = ensemble{1};
	niters = length(learningrates);
	treesperiter = length(ensemble) - 1;
	
	% initialize predictions
	n = length(X(:,1));
	if nargin < 3,
		p = zeros(n, treesperiter);
	end
	
	% compute predictions from trees
	for i=1:niters,
		learningrate = learningrates(i);
		for t=1:treesperiter,
			p(:,t) = p(:,t) + learningrate * evaltree(X, ensemble{t+1}{i});
	end
	end
end
