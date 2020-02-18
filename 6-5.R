install.packages("e1071")
library(e1071)

data(iris)

## split data into a train and test set
index <- 1:nrow(iris)
np = ceiling(0.1*nrow(iris))        # 10% 為測試資料
np

testindex = sample(1:nrow(iris),np)
testset <- iris[testindex,]
trainset <- iris[-testindex,]

## svm
svm.model <- svm(Species ~ ., data = trainset, type='C-classification', cost = 10, gamma = 10)
svm.pred <- predict(svm.model, testset[,-5])   

## compute svm confusion matrix
table.svm.test=table(pred = svm.pred, true = testset[,5])  # column 5 is dependent variable (target)
table.svm.test
correct.svm=sum(diag(table.svm.test))/sum(table.svm.test)
correct.svm=correct.svm*100
correct.svm



########################################################################################################################################################
# Now, we will use the tuned() function to do a grid search over the supplied parameter ranges (C-cost,gamma-gamma), using the train set. 
# The range to gamma parameter is between 0.001 and 0.1. 
# For cost parameter the range is from 0.1 until 10.
# It's important to understanding the influence of this two parameters, because the accuracy of an SVM model is largely dependent on the selection them. 
# For example, if C is too large, we have a high penalty for nonseparable points and we may store many support vectors and overfit. 
# If it is too small, we may have underfitting.
#########################################################################################################################################################

tuned <- tune.svm(Species ~., data = trainset, gamma = 10^(-3:-1), cost = 10^(-1:1)) 
summary(tuned)
model  <- svm(Species ~., data = trainset, kernel="radial", gamma=0.1, cost=10) 
summary(model)

svm.pred <- predict(model, testset[,-5])

## compute svm confusion matrix
table.svm.best.test=table(pred = svm.pred, true = testset[,5])  
table.svm.best.test
correct.svm.best=sum(diag(table.svm.best.test))/sum(table.svm.best.test)*100
correct.svm.best


