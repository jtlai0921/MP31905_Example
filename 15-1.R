# Free memory
rm(list = ls())
gc()

# Please run this program in SparkR
if (nchar(Sys.getenv("SPARK_HOME")) < 1) {
  Sys.setenv(SPARK_HOME = "/usr/local/spark")
}

library(SparkR, lib.loc = c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib")))

sparkR.session(appName = "SparkR-GLM")

#CsvPath <- "/home/spark/Ch15.csv"

#  Directly create a SparkDataFrame from the source data
#DF <- read.df(CsvPath, source = "csv", header = "true")

# Print the schema of this SparkDataFrame
#printSchema(DF)

######
setwd("/home/spark")
datacheck <- read.csv("Ch15.csv" , header = T, sep = ",")
datatrain <- datacheck[1:3984,] 
datatest <- datacheck[3985:4008,]  

#as.DataFrame()
spdatatrain <- as.DataFrame(datatrain)  #training data turn to spark's DataFrame 
spdatatest <- as.DataFrame(datatest)   #test data turn to spark's DataFrame 

#####  spark glm model
model <- spark.glm(spdatatrain, Temp ~ ., family = "Gamma")
summary(model)

preds <- predict(model, newData = spdatatest)

# 前六筆資料顯示 為了準備rmse指令用
head(select(preds, "Temp", "prediction"))

#rmse to spark 
#add squared residuals using transform
sq_resid <- transform(preds, sq_residuals = (preds$Temp - preds$prediction)^2)

#calculate MSE and collect locally - it is only a number
MSE <- collect(summarize(sq_resid, mean = mean(sq_resid$sq_residuals)))$mean

#RMSE
RMSE=sqrt(MSE) 
RMSE

#####  spark glm model
model <- spark.glm(spdatatrain, Temp ~ ., family = "gaussian")
summary(model)

preds <- predict(model, newData = spdatatest)

# 前六筆資料顯示 為了準備rmse指令用
head(select(preds, "Temp", "prediction"))

#rmse to spark 
#add squared residuals using transform
sq_resid <- transform(preds, sq_residuals = (preds$Temp - preds$prediction)^2)

#calculate MSE and collect locally - it is only a number
MSE <- collect(summarize(sq_resid, mean = mean(sq_resid$sq_residuals)))$mean

#RMSE
RMSE=sqrt(MSE) 
RMSE

sparkR.session.stop()