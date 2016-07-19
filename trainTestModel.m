% Assume we know what lambda-cv values we want. Now we want to train our
% model and apply our data. 
run('main.m')
clear; close all;
for kk = linspace(0,1,20)
min_lambda = kk;
max_lambda = min_lambda;
steps = 1;
trainSize=.9;
threshold = .5;

[~, ~, xtest,ytest]=penalized_l2(trainSize, min_lambda ,max_lambda,steps);
load('CV_results')
B = est_coef{1};
B=B(2:end-1);
yhat = logfcn(B,xtest)';
yhat(yhat> threshold) = 1;
yhat(yhat<=threshold) = 0;
% compare results
accuracy = sum(yhat == ytest)/length(ytest);
stem(kk,accuracy); hold on; xlabel('\lambda'); ylabel('accuracy')
end
axis([0 max_lambda 0 1])