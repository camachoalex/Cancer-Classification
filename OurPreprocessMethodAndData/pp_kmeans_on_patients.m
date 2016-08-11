%% Preprocessin via Clustering
% IN this method we use the kmeans algorithm to identify which genes are
% separable. This will be achieved via the kmeans algoithm. The kmeans
% algorithm will split each gene of a person into two clusters. We will then take the
% mean of each cluster and and comapre them to each other. If the means are
% similar we will keep the gene in our dataset, else we throw it out. Due
% to time constraints we use the two-mean t test with H0:meanA == meanB, 
% HA: meanA != meanB.

% imputed Bladder: Reduced from 125 patients to 91.
% imputed leuk : 73 reduced to 73. no change
% imputed colon: Reduced from 62 patients to 61.
% imputed liver: 181 to 181
% imputed prostate: 139 patients to 8.
% Change FileName
clear;

fileName = 'imputed_colon';

mpath = '~/Documents/Cancer-Classification/tmpNewDataDELETEME/';
outPath = '~/Documents/Cancer-Classification/OurPreprocessMethod/';
inFile = strcat(mpath,fileName,'.xlsx');
outFile = strcat(outPath,'PP_',fileName,'_patients');
DATA = xlsread(inFile);
HEAD = DATA(1,:);
flagVector = zeros(size(HEAD));
DATA = DATA(2:end,:); % get rid of header
DATA  = (DATA - mean(DATA(:)) )./std(DATA(:));
[m, n] = size(DATA);

tic
new_gene_data_set = [];
idx=1;
for k=1:n
    [assigned_class] = kmeans(DATA(2:end,k),2,'Distance','sqeuclidean');
    [h,p] = ttest2(DATA(assigned_class == 1),DATA(assigned_class == 2)); % comparison of two means. Calculates pvalue
    if(h == 1) % if we reject the null hypothesis
        new_gene_data_set(:,idx) = DATA(:,k);
        flagVector(k)=1;
        idx=idx+1;
    end
end
toc

%% Write to file
reduced_data = [HEAD(flagVector==1) ;new_gene_data_set];
%% 
 save(outFile,'reduced_data')
