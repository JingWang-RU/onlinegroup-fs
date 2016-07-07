% make
fprintf('compiling mex code...\n');
make

% setup openmp
setenv('OMP_NUM_THREADS','8');

% train
fprintf('training...\n');
data = load('/research-projects/mlgroup/yahoodata_mat/set2.train.mat');
xr = full(data.X);
yr = data.y;

options.learningrate=0.06;
options.depth=4;
options.ntrees=500;
options.verbose = true;

% costs = rand(size(xr,2),1)*100;
% options.computefeaturecosts = @(e) computefeaturecosts(1,costs,e);

tic;
[e,l] = gbrt(xr,@(p)sqrloss(yr,p),options);
toc
clear data xr yr

% validate
fprintf('validating...\n');
data = load('/research-projects/mlgroup/yahoodata_mat/set2.valid.mat');
xv = full(data.X);
yv = data.y;

[ev,s] = crossval(xv,@(p)sqrloss(p,yv),e);
fprintf('validation selected first %d trees\n', length(ev{1}));
clear data xv yv

% test
fprintf('testing...\n');
data = load('/research-projects/mlgroup/yahoodata_mat/set2.test.mat');
xe = full(data.X);
ye = data.y;

pe = evalensemble(xe,ev);
save('set2.test.pred.txt', 'pe', '-ASCII');
clear data xe ye