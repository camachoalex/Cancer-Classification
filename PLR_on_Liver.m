clear
load('HPC_Result_Liver.mat');
% Randomly create training set (80%)
%%
nn=30; idx = 0;
accuracy=zeros(1,nn);
threshold=.5;
for lambdaCV = .2
    [~,~, xtest, ytest] = penalized_l2(x,y,.8,lambdaCV,lambdaCV,1);
    load('CV_results')
    B = est_coef{1};
    B=B(2:end-1);
    yhat = logfcn(B,xtest)';
    yhat(yhat> threshold) = 1;
    yhat(yhat<=threshold) = 0;
    % compare results
    idx=idx+1;
    accuracy(idx) = sum(yhat == ytest)/length(ytest);
end
%% Plot accuracy
plot(linspace(0,5,30),accuracy,'o-');