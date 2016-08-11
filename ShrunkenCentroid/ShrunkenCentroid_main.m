%% 10-fold CV
% This script splits our data into 10 sets.
clear;clc;close all
run main

% load('HPC_Result_Liver');
% X_DATA= [y';x'];
% % [m,n] = size(x)
%%
X_DATA  = xlsread('~/Documents/Cancer-Classification/tmpNewDataDELETEME/imputed_colon.xlsx');
% X_DATA  = xlsread('~/Documents/Cancer-Classification/OurPreprocessMethod/imputed_bladder_.xls');
% load PP_imputed_colon_patients
% X_DATA = reduced_data;
%%
% % partion the data set into 10-folds
X_DATA=X_DATA;
[m n ] = size(X_DATA);
numFolds = 10;
idx = cvpartition(n,'KFold',numFolds);
loc=0;
tic
%%
mean_CV_Err_per_threshold=[];
lambda_min = 0;
lambda_max = 20;
nLambda = 10;

for lambda =[linspace(lambda_min, lambda_max,nLambda)]
    total_CV_Err =zeros(1,numFolds);
    for k=1:numFolds
        xtrain = X_DATA(:,idx.training(k) );
        xtest = X_DATA(:, idx.test(k));
        [CVErr] = ShrunkenCentroid_modified(xtrain,xtest, numFolds, lambda);
        total_CV_Err(k) =CVErr;
    end
    
    loc=loc+1;
    mean_CV_Err_per_threshold(loc) = mean(total_CV_Err);
end
toc
%%
lambda =[linspace(lambda_min,lambda_max,nLambda)];
plot(lambda, mean_CV_Err_per_threshold,'o-')
title('CV-Error');
%% Special case for prostate

% CVErr = ShrunkenCentroid(X_DATA(2:end,1:7),X_DATA(2:end,8), 1, 100)
