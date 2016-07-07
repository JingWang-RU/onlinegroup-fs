%%This function finds the number of trees that minimizes the metric value.

function [trees,score] = CrossVal(X,metric,ensemble)

%Initialize score, t, and trees
score= [1:length(ensemble)];
%Minimize metric value
p = zeros(size(evalensemble(X,ensemble(1))));
for t = 1:length(ensemble);
    p = evalensemble(X,ensemble(t),p); %Get Prediction
    score(t) = metric(p); %Gets score
end
[~,i] = min(score);     %Find the index of the minimum metric
trees = ensemble(1:i);  % Output i many trees
end

%metric=1-sum(test1==(p)))
 

