function [x, fobj] = ls_featuresign_sub (A, y, AtA, Aty, gamma, xinit)

[L,M] = size(A);

rankA = min(size(A,1)-10, size(A,2)-10);

% Step 1: Initialize
usexinit = false;
% if ~exist('xinit', 'var') || isempty(xinit)
xinit= [];
x= sparse(zeros(M,1));
theta= sparse(zeros(M,1));
act= sparse(zeros(M,1));
allowZero = false;
% else
% xinit = [];
%     x= sparse(xinit);
%     theta= sparse(sign(x));
%     act= sparse(abs(theta));
%     usexinit = true;
%     allowZero = true;
% end

fname_debug = sprintf('../tmp/fsdebug_%x.mat', datestr(now, 30));

fobj = 0; %fobj_featuresign(x, A, y, AtA, Aty, gamma);

ITERMAX=1000;
optimality1=false;
for iter=1:ITERMAX
    % check optimality0
    act_indx0 = find(act == 0);
    grad = AtA*sparse(x) - Aty;
    theta = sign(x);
    
    optimality0= false;
    % Step 2
    [mx,indx] = max (abs(grad(act_indx0)));
    
    if ~isempty(mx) && (mx >= gamma) && (iter>1 || ~usexinit)
        act(act_indx0(indx)) = 1;
        theta(act_indx0(indx)) = -sign(grad(act_indx0(indx)));
        usexinit= false;
    else
        optimality0= true;
        if optimality1
            break;
        end
    end
    act_indx1 = find(act == 1);
    
    if length(act_indx1)>rankA
        warning('sparsity penalty is too small: too many coefficients are activated');
        return;
    end
    
    if isempty(act_indx1) %length(act_indx1)==0
        % if ~assert(max(abs(x))==0), save(fname_debug, 'A', 'y', 'gamma', 'xinit'); error('error'); end
        if allowZero, allowZero= false; continue, end
        return;
    end
    
    % if ~assert(length(act_indx1) == length(find(act==1))), save(fname_debug, 'A', 'y', 'gamma', 'xinit'); error('error'); end
    k=0;
    while 1
        k=k+1;
        if k>ITERMAX
            warning('Maximum number of iteration reached. The solution may not be optimal');
            % save(fname_debug, 'A', 'y', 'gamma', 'xinit');
            return;
        end
        
        if isempty(act_indx1) % length(act_indx1)==0
            % if ~assert(max(abs(x))==0), save(fname_debug, 'A', 'y', 'gamma', 'xinit'); error('error'); end
            if allowZero, allowZero= false; break, end
            return;
        end
        
        % Step 3: feature-sign step
        [x, theta, act, act_indx1, optimality1, lsearch, fobj] = compute_FS_step (x, A, y, AtA, Aty, theta, act, act_indx1, gamma);
        
        % Step 4: check optimality condition 1
        if optimality1 break; end;
        if lsearch >0 continue; end;
        
    end
end

if iter >= ITERMAX
    warning('Maximum number of iteration reached. The solution may not be optimal');
    % save(fname_debug, 'A', 'y', 'gamma', 'xinit');
end

if 0  % check if optimality
    act_indx1 = find(act==1);
    grad = AtA*sparse(x) - Aty;
    norm(grad(act_indx1) + gamma.*sign(x(act_indx1)),'inf')
    find(abs(grad(setdiff(1:M, act_indx1)))>gamma)
end

fobj = fobj_featuresign(x, A, y, AtA, Aty, gamma);

return;
end
