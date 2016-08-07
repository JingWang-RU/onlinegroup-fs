
function [sList time_cost] = OGFS(X, Y, num_group, epsilon, gamma)

% Inputs:
%
%   X - data matrix X assumed n by m, n is the number of observations, m is the
%       dimension of feature space.
%
%   Y - groundtruth label of data matrix X
%
%  num_group - size of each group in the feature stream, assume each group
%              is with same size
% 
%  epsilon - parameter defining the improvement of inclusion a new feature
% 
%  gamma - parameter controlling the sparsity of inter-group selection
%
% Outputs:
%
%   slist - vector of index of selected features in original feature space
%
%   time_cost - time cost of the algorithm

% Reference:
%
%    Jing Wang, Zhong-Qiu Zhao, Xuegang Hu, Yiu-Ming Cheung, Meng Wang,and Xindong Wu. 
%    Online group feature selection. IJCAI, 1757-1763, 2013.
%
%    Jing Wang, Meng Wang, Peipei Li, Luoqi Liu, Zhongqiu Zhao, Xuegang Hu, and Xindong Wu.
%    Online Feature Selection with Group Structure Analysis. TKDE, 27(11),
%    3029-3041, 2015.
% 
% There are some updates based on the algorithms in the previous papers.
% Written by: Jing Wang
% Email: jw998@rutgers.edu

if nargin < 5
    gamma = 0.001;
end
if nargin < 4
    epsilon = 0.001;
end
sList = [];
add_num = 0;
score = [];
fenzi = [];
fenmu = [];

% gamma = 0.4; %for sparse coding
numF = size(X,2);
% normalize if necessary
% for i = 1 : numF
%     X(i,:) = X(i,:) /norm( X(i,:) ) ;
% end
tic;
[cIDX, numC ,num_class] = adjacent_matrix(numF,Y);
% simulate the feature stream
for i = 1:numF
    if i == 1
        [temp1 temp2] = feature_spectral(X(:,i), cIDX, numC, num_class);
        fscore = temp1/temp2;
        sList = [sList i];
        score = [score fscore];
        fenzi = [fenzi temp1];
        fenmu = [fenmu temp2];
        F_U = sum(fenzi)/sum(fenmu);
        break;
    end
    [temp1 temp2] = feature_spectral(X(:,i),cIDX,numC,num_class);
    fscore = temp1/temp2;
    mean_score = sum(score)/size(score,2);
    l = ones(1, size(score,2));
    l = l*mean_score;
    
    feature_level = (fscore - mean_score);
    tfenzi = [fenzi temp1];
    tfenmu = [fenmu temp2];
    F_Ufi = sum(tfenzi)/sum(tfenmu);
    
    if length(sList) < num_group + add_num
        %      if abs(F_Ufi-F_U)>= epsilon
        %              if (((F_Ufi-F_U)/F_U > c_one) || abs(t)>c_two) % 16.43 393;15   997
        if (((F_Ufi - F_U) > 0) || (abs(feature_level)> epsilon) )%c_two
            sList = [sList i];
            fenzi = tfenzi;
            fenmu = tfenmu;
            score = [score fscore];
            F_U = F_Ufi;
        end
    else
%         inter_group selection
        Xout = inter_group_selection (X(:,sList), Y, gamma);
        ind = find(Xout~=0);
        if length(ind) == num_group
            num_group = num_group + 1;
        else
            sList = sList(ind);
            score = score(ind);
            fenzi = fenzi(ind);
            fenmu = fenmu(ind);
            F_U = sum(fenzi)/sum(fenmu);
        end
        i = i-1;
        add_num = length(sList);
    end
end
time_cost = toc;
end