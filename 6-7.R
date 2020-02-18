
# free memory
rm(list = ls())
gc()

library(randomForest)

ind <- sample(2, nrow(iris), replace=TRUE, prob=c(0.8, 0.2))
trainData <- iris[ind==1,]
testData <- iris[ind==2,]


rf <- randomForest(Species ~ ., data=trainData, ntree=100)

irisPred <- predict(rf, newdata=testData)
table(irisPred, testData$Species)

