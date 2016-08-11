%% Preprocessin via Clustering
% IN this method we use the kmeans algorithm to identify which genes are
% separable. This will be achieved via the kmeans algoithm. The kmeans
% algorithm will split each gene into two clusters. We will then take the
% mean of each cluster and and comapre them to each other. If the means are
% similar we will keep the gene in our dataset, else we throw it out. Due
% to time constraints we use the two-mean t test with H0:meanA == meanB, 
% HA: meanA != meanB.

% imputed Bladder: 6689 genes to 326
% imputed leuk : 7129 genes to 180
% imputed colon: 2000 genes to 1119
% imputed liver: 5520 genes to 181
% imputed prostate: 244 genes to 12

clear;clc
% Change FileName
fileName = 'imputed_bladder';

mpath = '~/Documents/Cancer-Classification/tmpNewDataDELETEME/';
outPath = '~/Documents/Cancer-Classification/OurPreprocessMethod/';
inFile = strcat(mpath,fileName,'.xlsx');
outFile = strcat(outPath,'PP_',fileName,'_gene');
DATA = xlsread(inFile);
[num_genes_in, num_patients_in] = size(DATA);
HEAD = DATA(1,:);
DATA = DATA(2:end,:)'; % get rid of header and transpose data.
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
        idx=idx+1;
    end
end
toc

%% Write to file
reduced_data = [HEAD ;new_gene_data_set']; 
[num_genes_out, num_patients_out] = size(reduced_data);
save(outFile,'reduced_data','num_genes_out','num_patients_out','num_genes_in','num_patients_in')
