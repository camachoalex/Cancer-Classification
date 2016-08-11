%% 10-fold CV
% This script splits our data into 10 sets.
clear;clc;
% DATA = xlsread('imputed_liver.xlsx');
fileName='PP_imputed_bladder_patients';
load(fileName);
DATA = reduced_data;
x = DATA(2:end,:)';
y = DATA(1,:)';
[m,n] = size(x);
%%
% partion the data set into 10-folds
numFolds = 10; % <<< change to num of folds you want.
idx = cvpartition(m,'KFold',numFolds);
loc=0;
tic
for lambda = 1:10
    accuracy =zeros(1,numFolds);
    for k=1:numFolds
        xtrain = x(idx.training(k),:);
        ytrain = y(idx.training(k));
        ytest = y(idx.test(k));
        xtest = x(idx.test(k),:);
        [xhat, B] = penalized_l2_kfold(xtrain,ytrain,lambda, lambda,1);
        alpha_tilde = B(1,1);
        B=B(2:end);
%         lambdaTmp = linspace(0, lambda,length(B));
%         plot(lambdaTmp,B(1),'o-'); hold on;
%         yhat = sort(logfcn(xtrain,B,alpha_tilde)); %% to plot the S-curve

        result = logfcn(xtest,B, alpha_tilde)';
        result(result >.5) =1;
        result(result<=.5) = 0;
        accuracy(k) = sum(result==ytest)/length(ytest);
    end

    loc=loc+1;
    lambda_10_fold_accuracy(loc) = mean(accuracy);
end
toc
disp(fileName)
lambda_10_fold_accuracy
