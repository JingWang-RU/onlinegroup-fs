function Xout = inter_group_selection (A, Y, gamma)
% This code refers to the code in the following paper:
% 'Efficient Sparse Codig Algorithms', Honglak Lee, Alexis Battle, Rajat Raina, Andrew Y. Ng,
% Advances in Neural Information Processing Systems (NIPS) 19, 2007
%
% Written by Honglak Lee <hllee@cs.stanford.edu>
% Copyright 2007 by Honglak Lee, Alexis Battle, Rajat Raina, and Andrew Y. Ng

AtA = A'*A;
AtY = A'*Y;

rankA = min(size(A,1)-10, size(A,2)-10);
i=1;

if mod(i, 100)==0, fprintf('.'); end 
[Xout, fobj]= ls_featuresign_sub (A, Y, AtA, AtY, gamma);

return;
end
