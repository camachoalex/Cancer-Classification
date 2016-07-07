addpath('cancer_data')
% read data
A = xlsread('imputed_prostate.xls'); %243 genes, 139 patiens
A=A(2:end,:); % omit header
% Cluster everything naively. k-means reads observations as rows. 
[IDX, C, SUMD,D] = kmeans(A',100,'Distance','sqeuclidean');
