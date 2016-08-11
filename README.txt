**************************************************************
MATLAB Code for: Penalized Logistic Regression & Nearest Shrunken Centroid for Cancer Classification of Gene Microarrays

Authors: Alejandro Camacho, Khoa Ta, Duy Tran.

Email: 
camacho@csu.fullerton.edu
khoata_us@yahoo.com
duyqt@csu.fullerton.edu

MATLAB VERSION: R2015b - academic use

!~ By running these programs, the author(s) assume no responsibility for any damages  due to overheating.  
**************************************************************
!!!!! IMPORTANT STEP !!!!!
Open Matlab and navigate to the main code directory. Your directory should look like below:
%YOUR_DIRECTORY%\Group1Code\

Now add all folders and files to path. In the command window enter: 
main
**************************************************************
FUNCTION: main.m
This function adds all folders to path.
**************************************************************
FOLDER:OrigData
Contains all of the original cancer data in .txt and .xls format.
**************************************************************
FOLDER:OurPreprocessMethodAndData
Contains our preprocessed data prefixed by PP in .mat format. This format allows the user to double click and read in the data as a nxm matrix.

FUNCTION:pp_kmeans_on_genes.m
>Change line 18 to the cancer name you wish to run.
>Change line 20,21 to your computer directory. (I run MAC, Windows uses C:\).
Hit RUN and the output will automatically created.

FUNCTION:pp_kmeans_on_patients.m
>Change line 18 to the cancer name you wish to run.
>Change line 20,21 to your computer directory. (I run MAC, Windows uses C:\).
Hit RUN and the output will automatically created.
**************************************************************
FOLDER: PLR_L2

FUNCTION: PLRk_fold.m
> Change line 7 to the file name you wish to run. If you are running the original dataset, use line 10. If running with preprocess data use line 13-14.
Hit RUN.
You have the option to plot the s-curve by uncommenting line 34. (NOTE this slows down the computer dramatically.)

SUB_FUNCTION:penalized_l2_kfold.m
> Routine call the penalized logistic regression routine with inputs training data and tuning parameter range.

SUB_FUNCTION(S): initW.m logfcn.m
> subfunctions for initializing variables in the penalized logistic regression algorithm.
**************************************************************
FOLDER: ShrunkenCentroid

FUNCTION: ShrunkenCentroid_main.m
>Modify line 6 to appropriate file name.
>If running preprocessed data use lines 11-12.
Hit RUN.

SUB_FUNCTION: ShrunkenCentroid.m
This function calls the shrunken centroid method including the correction term.

SUB_FUNCTION: ShrunkenCentroid_modified.m
This function calls the shrunken centroid method without the correction term.
**************************************************************