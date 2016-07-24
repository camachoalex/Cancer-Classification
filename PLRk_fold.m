%% 10-fold CV
% This script splits our data into 10 sets.
clear;clc;
load('HPC_Result_Liver');
[m,n] = size(x);
% partion the data set into 10-folds
numFolds = 10;
idx = cvpartition(m,'KFold',numFolds);
loc=0;
tic
for lambda = 1
    accuracy =zeros(1,numFolds);
    for k=1:numFolds
        xtrain = x(idx.training(k),:);
        ytrain = y(idx.training(k));
        ytest = y(idx.test(k) == 1);
        xtest = x(idx.test(k) == 1,:);
        [xhat, B] = penalized_l2_kfold(xtrain,ytrain,lambda, lambda,1);
        B=B(2:end);
        yhat = sort(logfcn(B,xtrain));

        result = logfcn(B,xtest)';
        result(result >.5) =1;
        result(result<=.5) = 0;
        accuracy(k) = sum(result==ytest)/length(ytest);
    end
    loc=loc+1;
    lambda_10_fold_accuracy(loc) = mean(accuracy);
end
toc
lambda_10_fold_accuracy
