function [f, g] = fobj_featuresign(x, A, y, AtA, Aty, gamma)

f= 0.5*norm(y-A*x)^2;
f= f+ gamma*norm(x,1);

if nargout >1
    g= AtA*x - Aty;
    g= g+ gamma*sign(x);
end

return;
end