function [loss,gradient] = sqrloss(y,p)
%function [loss,gradient] = sqrloss(y,p)
%   
%  Input:
%   y = data of dimension dxn  (d features, n data points)
%  p =
%
% Output:
% 

	gradient = y(:)-p(:);
	loss = 1/2*gradient'*gradient;
end