function [vensemble,score] = crossval(X,metric,ensemble)
	% compute metric after each additional tree
	p = evalensemble(X, {ensemble{1}(1), {ensemble{2}{1}} });
	score(1) = metric(p);
	for t = 2:length(ensemble{1});
	    p = evalensemble(X, {ensemble{1}(t), {ensemble{2}{t}} }, p); % get prediction
	    score(t) = metric(p); % get score
	end
	
	% return  first i trees minimizes metric on validation set
	[~,i] = min(score);
	vensemble = {ensemble{1}(1:i), ensemble{2}(1:i)};
end

 

