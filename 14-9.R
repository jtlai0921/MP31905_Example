# Free memory
rm(list = ls())
gc()

# Please run this program in SparkR
if (nchar(Sys.getenv("SPARK_HOME")) < 1) {
  Sys.setenv(SPARK_HOME = "/usr/local/spark")
}

library(SparkR, lib.loc = c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib")))

## Initialize SparkSession
sparkR.session(appName = "SparkR-data-analysis-example")

irisDF <- suppressWarnings(createDataFrame(iris))
kmeansDF <- irisDF
#temp_kmeansDF <- as.data.frame(kmeansDF)

kmeansTestDF <- irisDF
kmeansModel <- spark.kmeans(kmeansDF, ~ Sepal_Length + Sepal_Width + Petal_Length + Petal_Width,k = 3)

# Model summary
summary(kmeansModel)

# Get fitted result from the k-means model
fitted_kmeans=fitted(kmeansModel)
head(fitted_kmeans)

fitted_kmeans=as.data.frame(fitted_kmeans)

# Fit a random forest classification model with spark.randomForest
model <- spark.randomForest(kmeansDF, Species ~ ., "classification", numTrees = 10)

# Model summary
summary(model)

# Prediction
predictions <- predict(model, kmeansTestDF)
showDF(predictions)
predictions=as.data.frame(predictions)

# Stop the SparkSession now
sparkR.session.stop()
