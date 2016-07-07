function [score] = maxmetric(p,y)

    [~,I] = max(p,[],2);
    score = 1-sum(y==(I))/length(y);
end