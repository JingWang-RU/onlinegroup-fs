function [featurecosts] = groupfeaturecosts(lambda, defaultcosts, group, ensemble);
	global groupsparsity;
	global sparsity;
	defaultcosts = sparsity;
    alltrees = vertcat(ensemble{2}{:});
	if length(alltrees) > 0,
		usedfeatures = unique(alltrees(:,1));
		usedfeatures = usedfeatures(usedfeatures>0);
		
		groups = unique(group(usedfeatures));
		groupsparsity(groups) = 0;
		
		for t=1:max(group)
			featurecosts(group==t) = groupsparsity(t) * lambda;
		end
	else
		featurecosts = lambda * defaultcosts;
	end
end
