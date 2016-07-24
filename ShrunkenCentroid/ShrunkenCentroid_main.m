%% 10-fold CV
% This script splits our data into 10 sets.
clear;clc;
run main
load('HPC_Result_Liver');
X_DATA= [y';x'];

[m,n] = size(x);
% partion the data set into 10-folds
numFolds = 10;
idx = cvpartition(m,'KFold',numFolds);
loc=0;
tic

mean_acc=[];
for lambda =[linspace(12,13,30)]
    accuracy =zeros(1,numFolds);
    for k=1:numFolds
        xtrain = X_DATA(:,idx.training(k) );
        xtest = X_DATA(:, idx.test(k));
        
        [acc_tmp,CVErrorTmp] = ShrunkenCentroid(xtrain,xtest, lambda);
        accuracy(k) =acc_tmp;
    end
    loc=loc+1;
    mean_acc(loc) = mean(accuracy);
end
toc
%%
lambda =[linspace(12,13,30)];
plot(lambda, mean_acc,'o')
shg
