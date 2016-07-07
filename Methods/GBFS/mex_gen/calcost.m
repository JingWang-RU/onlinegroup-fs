function [totalcost,totalfeat] = calcost(e,cost)
	
	totalfeat = zeros(length(e{2}),length(cost));
	for tree = 1:length(e{2})
		validfeat = find(e{2}{tree}(:,1)~=0);
		totalfeat(tree,e{2}{tree}(validfeat,1)) = 1;
	end

	% totalfeat
	totalfeat = cumsum(totalfeat,1); 
	totalfeat = (totalfeat>0);
	
	% totalcost
	totalcost = totalfeat*cost';
		
