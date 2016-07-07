% function [tst_prec,val_prec,beststep,totalcost] = evaluate(e,options,cost,xtr,ytr,xtv,ytv,xte,yte,traqs,valqs,tstqs)
 function [beststep] = evaluate(e,options,cost,xtr,ytr,xtv,ytv,traqs,valqs,tstqs)
	% evaluation code, we evaluate at every 10 trees
	
	% input:
	% e, GBFS trees
	% options, GBFS tree information
	% cost = 1*d, sparsity information
	% xtr = n*d, ytr = n*1, 
	% traqs = n*1, queries only valid for ranking data.
	
	% output:
	% tst_prec: testing accuracy at every 10 trees, n*(ntrees/10)
	% val_prec: validation accuracy at every 10 trees, n*(ntrees/10)
	% beststep: best number of trees based on validation set
	% totalcost: total cost at every 10 trees, 1*(ntrees/10);
	
	ntrees = length(e{1});
	eall = cell2mat(e{2}');
	% we evaluate at every 10 trees
% 	tst_preds = evalensemble_c(xte,eall,options.depth,options.learningrate,10);
% 	tst_preds = cumsum(tst_preds,2);
	val_preds = evalensemble_c(xtv,eall,options.depth,options.learningrate,10);
	val_preds = cumsum(val_preds,2);

	% for every 10 trees, we compute accuracy
	alldims = [10:10:ntrees];
	for dd=1:length(alldims)
		% keyboard
% 		tst_prec(dd) = mean(sign(tst_preds(:,dd))==yte);
		val_prec(dd) = mean(sign(val_preds(:,dd))==ytv);
	end
	% return total cost, and total feature, recorded at every 10 trees.
	[totalcost,totalfeat] = calcost(e,cost);
	totalcost = totalcost(alldims) + alldims';

	% return the best number of trees based on validation set.
	[~,beststep] = max(val_prec);
	