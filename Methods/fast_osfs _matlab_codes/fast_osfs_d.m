function   [selected_features1,time]=fast_osfs_d(data1,target,alpha,test)


%for disccrete data


%important note:
%for discrete dataset: the feature values of X must be from 1 to dom(X), for example, if feature X have
% two values, in data, the two values are denoted as [1,2].


%input parameter:

%data1: data with all features including the class attribute
%target: the index of the class attribute ( we assume the class attribute is the last colomn of a dataset)
%alpha: significant level( 0.01 or 0.05 )
%for discrete data: test = 'chi2' for Pearson's chi2 test;'g2' for G2 likelihood ratio test

%for example: The UCI dataset wdbc with 569 instances and 31 features (the index of the  class attribute is 31).

%[selected_features1,time]=fast_osfs_d(wdbc,31,0.01,'g2')

% if  the feature values of X must be from 0 to dom(X)-1,then 

%[selected_features1,time]=fast_osfs_d(wdbc+1,31,0.01,'g2')

%output: 
%selected_features1: the selected features
%time: running time

%please refer to the following papers for the details and cite them:
%Wu, Xindong, Kui Yu, Wei Ding, Hao Wang, and Xingquan Zhu. "Online feature selection with streaming features." Pattern Analysis and Machine Intelligence, IEEE Transactions on 35, no. 5 (2013): 1178-1192.
%Wu, Xindong, Kui Yu, Hao Wang, and Wei Ding. "Online streaming feature selection." In Proceedings of the 27th international conference on machine learning (ICML-10), pp. 1159-1166. 2010.


tic

[n,p]=size(data1);
ns=max(data1);
selected_features=[];
selected_features1=[];
b=[];


 for i=1:p-1%the last feature is the class attribute, i.e., the target)
    
 
      if mod(i,1000)==0
         i
      end
     
     n1=sum(data1(:,i));
      if n1==0
         continue;
      end
      
     stop=0;
      CI=1;
      if sum(data1(:,i))==0 %for very sparse data
          break;
      end
      [CI] = my_cond_indep_chisquare(data1,i, target, [], test, alpha, ns);
      
      if CI==0
          stop=1;
      end
         
          if stop
              
                if ~isempty(selected_features)
                    [CI]=compter_dep_2(selected_features,i,target,3, 1, alpha, test,data1);
                end              
                           
                if CI==0
                    
                    selected_features=[selected_features,i]; %adding i to the set of selected_features
                    p2=length(selected_features);
                    selected_features1=selected_features;           
                  
                    for j=1:p2-1
 
                       b=setdiff(selected_features1,selected_features(j), 'stable');  
                       if ~isempty(b)
                         [CI]=optimal_compter_dep_2(b,selected_features(j),target,3, 1, alpha, test,data1);                    
                                 
                          if CI==1
                              selected_features1=b;
                          end
                       end
                    end
                end
          end
   selected_features=selected_features1;
 end
time=toc;    

   
  
    
      