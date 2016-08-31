function [temp1 temp2] = feature_spectral(f_i, cIDX, numC,num_class)

temp1 = 0;
temp2 = 0;
%     f_i = X(:,i);
u_i = mean(f_i);

for j = 1:numC
    u_cj = mean(f_i(cIDX{j}));
    var_cj = var(f_i(cIDX{j}),1);
    temp1 = temp1 + num_class(j) * (u_cj-u_i)^2;
    temp2 = temp2 + num_class(j) * var_cj;
end
% if temp1 == 0
%     score = 0;
% else
if temp2 == 0
    temp2 = 0.000001;
    %         score=100;
    %     else
    %         score = temp1/temp2;
    %     end
end

end
