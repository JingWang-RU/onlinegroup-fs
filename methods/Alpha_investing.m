
% Below is the main streamwise feature selection (SFS) code. It uses two helper functions, Linear_Regression and Prediction_Error 
% the main function, Alpha_Investing , 

%  function [w,model] =Alpha_Investing(X, y, no_para_1, no_para_2)
function flist =Alpha_Investing(X, y, no_para_1, no_para_2)
 % configure parameters (I never change these)
%  tic
   wealth = 0.5;%no_para_1;%0.5;
   delta_alpha = 0.5;%no_para_2;%0.5;
 % n observations; p features
   [n,p] = size(X);
 % initially add constant term into the model
   model = [1, zeros(1,p-1)];
   error = Prediction_Error(X(:,model==1), y, Linear_Regression(X(:,model==1), y));
 for i=2:p
     %i
   alpha = wealth/(2*i);
   %i
   %compute p_value
   %method one: derive delta(loglikelihood) from L2 error
   model(i) = 1;
   error_new = Prediction_Error(X(:,model==1), y, Linear_Regression(X(:,model==1), y));
   sigma2 = error/n;
   p_value = exp((error_new-error)/(2*sigma2));
%    fprintf(1,'p_value %f\n',p_value);
%    fprintf(1,'alpha %f\n',alpha);
   %method two: derive delta(loglikelihood) from t-statistic
   %model(i) = 1;
   %w = Linear_Regression(X(:,model==1), y);
   %sigma2 = Prediction_Error(X(:,model==1), y, w)/n;
   %EX = mean(X(:,model==1));
   %w_new_std = w(end)/sqrt(sigma2/(sum(sum((X(:,model==1)-ones(n,1)*EX).^2, 2))));
   %p_value = 2*(1-normcdf(abs(w_new_std), 0, 1));
   
   if p_value < alpha %feature i is accepted
%        fprintf(1,'selected %d\n',length(model==1));
       model(i) = 1;
       error = error_new;
       wealth = wealth + delta_alpha - alpha;
   else %feature i is discarded
       model(i) = 0;
       wealth = wealth - alpha;
   end
 end
 % train final model
  w = zeros(p,1);
  w(model==1,1) = Linear_Regression(X(:,model==1), y);
  flist = find(w~=0);
%   toc
  % Linear_Regression 
function [w] = Linear_Regression(X, y)
   % this is not the most efficient way to find w!
  w = inv(X'*X)*X'*y;
   %w=regress(y,X);
   
  % Prediction_Error 
  function [error] = Prediction_Error(X, y, w)
     yhat = X*w;
     error = sum((y-yhat).^2);
