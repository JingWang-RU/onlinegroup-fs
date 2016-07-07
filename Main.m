% Created by Jing Wang (jw998@rutgers.edu)
% main demo function for datasets in ./Data/mat/
clear;
addpath('./Tool/');
addpath(genpath('./Methods/'));
data_sets = {'wdbcM', 'ionM', 'spectfM', 'spambaseM', 'colonM', 'prostateM', 'leukemiaM', 'lungCancerM'};
timeS = zeros(length(data_sets),1);

result_fold = './Result/';
methods = {'OGFS', 'Alpha_investing', 'LassoGrafting', 'fast_osfs_z_k', 'Lars', 'MI', 'GBFS_revisit', 'baseline'};
for j = 1 : 1%length(methods)
    Method = methods{j};
    if ~exist([result_fold methods{j} '/'], 'dir')
        mkdir([result_fold methods{j} '/']);
    end       
    for i = 1 : 1%length(data_sets)
        file_data = data_sets{i};
        load(['./Data/mat/' file_data '.mat']);
        m = size(full, 2);  %label
        n = m-1;
        X = full(:, 1:n);
        Y = full(:, m);
        
        zero = find(Y==0);
        Y(zero,:)= -1; %label be [-1,1]
        
        switch Method
            case 'MI'
                %the number of quantization levels used for the features (default = 12)
                param_one = 12;
                %num_sel:number of selected features
                param_two = 20;
            case 'baseline'
                param_one = 0;
                param_two = 0;
            case 'Lars'
                %usually 0.15, no more than 20 percent of features selected
                param_one = 0.15;
                param_two = '';
            case 'GBFS_revisit'
                param_one = '';
                param_two = 1e-5;%lambda
            case 'OGFS'
                %55; %size(train_x,2)-1; % the size of the group: the number of samples in a group
                param_one = 20;
                %0.001; % gamma for the sparse coding, 0.4 as the default
                param_two = 0.0001;
            case 'Alpha_investing'
                param_one = 0.5;
                param_two = 0.5;
            case 'LassoGrafting'
                % need to be tuned, from 10^{-6}~0.1
                param_one = 0.5;
                param_two = [];
            case 'fast_osfs_z_k'
                param_one = 50;
                % chi2 or g2, g2 is the default
                param_two = '';
        end       
        
        save_name = [result_fold Method '/' file_data '_' Method '_' num2str(param_one) '_' num2str(param_two) '.mat'];
        fprintf(1,[Method ' param_one is: %d and param_two is: %f\n'],param_one, param_two);
        if exist([save_name '_list.mat'])
            load([save_name '_list.mat']);
        else
            if strcmp(Method, 'baseline');
                time = 0;
                fea_list = 1:size(X,2);
            else
                tic;
                fea_list = eval( [ Method '( X , Y, param_one, param_two)' ] ) ;
                ex_time = toc;
                timeS(i) = ex_time;
            end
        end
        fprintf(1,'The size of selected feature space is %d\n', length(fea_list));
        fprintf(1,'The time is %f\n',ex_time);
        if length(fea_list) == 0
            disp('error');
        else
            X = X(:, fea_list);
            % d = data(X,Y);
            accu = classify_tri_model(X, Y);
            fprintf(1,'The accuracy is %f\n', max(accu));
            
            save (save_name, 'fea_list', 'accu', 'ex_time');
        end
    end
end

