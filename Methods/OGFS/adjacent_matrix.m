function [cIDX, numC, num_class] = adjacent_matrix(numF,Y)
class_set = unique(Y);
numC = length(class_set);
cIDX = cell(numC,1);
num_class = zeros(numC,1);
for j = 1:numC
    cIDX{j} = find(Y(:) == class_set(j));
    num_class(j) = length(cIDX{j});
end
end

