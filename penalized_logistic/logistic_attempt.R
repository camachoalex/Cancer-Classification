#install.packages("gdata")
#install.packages("brglm")
install.packages("logistf")
library(logistf)
library(brglm)
library(gdata)
setwd("~//Desktop//Cancer_Classification_Code//cancer_data//")
A = read.xls("imputed_prostate.xls",header=FALSE)
y = t(A[1,]) # assigned class 1 or 2
x = A[ seq( 2,dim(A)[1] ) , ]
x=t(x) # transpose

# logistic stuff
lr2=logistf(y~x)
summary(lr2)