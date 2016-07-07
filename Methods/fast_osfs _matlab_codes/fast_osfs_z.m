function   [selected_features1,time]=fast_osfs_z(data1,target,alpha)


%for continouous data

%input parameter:

%data1: data with all features including the class attribute
%target: the index of the class attribute (we assume the class attribute is the last colomn of data1)
%alpha: significant level( 0.01 or 0.05 )
%for example: The UCI dataset wdbc with 569 instances and 31 features (the index of the  class attribute is 31).

% [selected_features1,time]=fast_osfs_z(wdbc,31,0.01)

%output: 
%selected_features1: the selected features
%time: running time

%please refer to the following papers for the details and cite them:
%Wu, Xindong, Kui Yu, Wei Ding, Hao Wang, and Xingquan Zhu. "Online feature selection with streaming features." Pattern Analysis and Machine Intelligence, IEEE Transactions on 35, no. 5 (2013): 1178-1192.
%Wu, Xindong, Kui Yu, Hao Wang, and Wei Ding. "Online streaming feature selection." In Proceedings of the 27th international conference on machine learning (ICML-10), pp. 1159-1166. 2010.


tic
[n,p]=size(data1);

%the data may be normalized
%data1_n=normalize(data1(:,1:p-1));
%label_c=center(data1(:,p));
%data1=[data1_n,data1(:,p)];
%end normalizing data


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
     
        [CI,dep]=my_cond_indep_fisher_z(data1,i,target,[],n,alpha);
        
        if CI==1|| isnan(dep)
          continue;
        end
        
         if CI==0
           stop=1;
         end
         
       if stop
           
           if ~isempty(selected_features)
               [CI,dep]=compter_dep_2(selected_features,i,target,3, 0, alpha, 'z',data1);
           end
           
           if CI==0 && ~isnan(dep)
                    
               selected_features=[selected_features,i]; %adding i to the set of selected_features
               p2=length(selected_features);
               selected_features1=selected_features;           
                  
               for j=1:p2-1
 
                 b=setdiff(selected_features1,selected_features(j), 'stable');
             
                 if ~isempty(b)
                     
                   [CI,dep]=optimal_compter_dep_2(b,selected_features(j),target,3, 0, alpha, 'z',data1);
                   
                   if CI==1 || isnan(dep)
                       selected_features1=b;  
                   end
               end

            end
           end
       end
    
   selected_features=selected_features1; 
 end
time=toc;
   
  
    
      