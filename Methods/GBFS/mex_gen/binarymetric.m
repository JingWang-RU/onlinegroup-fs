function [score] = binarymetric(y,p)
    score = 1-sum(y==((p>0)*2-1))/length(y);
end