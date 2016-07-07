function accu = classify_tri_model(X,Y)
% set label to 1,-1
ind_zeros = find(Y==0);
Y(ind_zeros, :)= -1; 

% X = X(:,list);
d = data(X,Y);
jj = get_mean ( train (cv( j48, 'folds=10'), d ) ) ;
j2 = 1-jj{1}.Y;
jjj = j2(1);
kk = get_mean ( train (cv( knn, 'folds=10'), d ) ) ;
k2 = 1 - kk{1}.Y;
kkk = k2(1);
rr = get_mean ( train (cv( randomforest, 'folds=10'), d ) ) ;
r2 = 1-rr{1}.Y;
rrr = r2(1);
accu = [jjj kkk rrr];
end