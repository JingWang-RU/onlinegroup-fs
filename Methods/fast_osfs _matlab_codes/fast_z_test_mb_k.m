function [current_feature,time] = fast_z_test_mb_k(k,k1,alpha,class, class_data,filename1)

%
%Performs approximate markov blanket discovery using the fast_z test.

%k: the nubmer of the partition of the data file
%k1: the nubmer of the selection of top-k feautres

tic

dep=-1*ones(1,class-1);
m=0;
b=0;

tem_order=[];

tem_data=[];

current_feature=[];



for w=1:k
    

filename=strcat(filename1,strcat(num2str(w),'.mat'));
c=load(filename, '-mat');
data=c.data;


data=[data,class_data];
[n,numFeatures] = size(data);

class_a=numFeatures;


CI=1;

for i= 1:numFeatures-1 
    
      m=m+1; 
  
   if mod(m,10000)==0     
      disp('the current processing feature is');
      m
   end
       
    [CI,dep(m)] = my_cond_indep_fisher_z(data,i, class_a, [],n,alpha);
    
    
    if CI==1 || isnan(dep(m))
       
        continue;
    end
    
       current_feature=[current_feature, m];
       
       %add new code for select top k1 features from the current_feautre set
       l_s=length(current_feature);
      
      if l_s>k1
          
          a_t=dep(current_feature);
          [a_t1,v1]=sort(a_t,'descend');
          v2=v1(1:k1);
          current_feature=current_feature(v2);
      end
      
      if isempty(find(current_feature==m))% if current_feature set doesn't contain m, then consider the next feature
            continue;
      end
       %end adding new code for select top k1 features from the current_feautre set
       
       
       b=b+1;
       tem_data=[tem_data data(:,i)];
       tem_order(b)=m; 
       
      
        current_feature1=current_feature(~sum(bsxfun(@eq,current_feature',m),2));
       
    if ~isempty(current_feature1)
                
          p=length(current_feature1);
              
          for j=1:p
          
                             f_i=size(tem_data,2);
                             f_j=find(tem_order==current_feature1(j));
                 [CI, dep_ij] = my_cond_indep_fisher_z(tem_data,f_i, f_j, [],n,alpha);
                                                    
                  t_dep=dep_ij;
                  t_feature=current_feature1(j);
                  
                  if CI==1|| isnan(t_dep)
                
                     continue;
                  end
                  
                 if dep(t_feature)>=dep(m) & t_dep>=max([dep(m),dep(t_feature)])
                     
                           
                           current_feature=current_feature(~sum(bsxfun(@eq,current_feature',m),2));                           
                            tem_data(:,b)=[];
                            tem_order(b)=[];
                            b=b-1;
                            break;
                   end
                   
                  %Dawei, I removed the following code:
                         
                  %if dep(m)>dep(t_feature) & t_dep>dep(t_feature)
                 
                           
                        %   current_feature=current_feature(~sum(bsxfun(@eq,current_feature',t_feature),2));
                           
                         %   f_j=find(tem_order==current_feature1(j));
                         %   tem_data(:,f_j)=[];
                         %   tem_order(f_j)=[];
                          %  b=b-1;
                  % end
                 
                   
          end
               
   end
    
end
end
time=toc


  

  
