# Rattle is Copyright (c) 2006-2014 Togaware Pty Ltd.

#============================================================
# Rattle timestamp: 2015-02-16 08:52:48 x86_64-w64-mingw32 

# Rattle version 3.4.1 user 'ISLab'

# Export this log textview to a file using the Export button or the Tools 
# menu to save a log of all activity. This facilitates repeatability. Exporting 
# to file 'myrf01.R', for example, allows us to the type in the R Console 
# the command source('myrf01.R') to repeat the process automatically. 
# Generally, we may want to edit the file to suit our needs. We can also directly 
# edit this current log textview to record additional information before exporting. 
 
# Saving and loading projects also retains this log.

library(rattle)

# This log generally records the process of building a model. However, with very 
# little effort the log can be used to score a new dataset. The logical variable 
# 'building' is used to toggle between generating transformations, as when building 
# a model, and simply using the transformations, as when scoring a dataset.

building <- TRUE
scoring  <- ! building

# The colorspace package is used to generate the colours used in plots, if available.

library(colorspace)

# A pre-defined value is used to reset the random seed so that results are repeatable.

crv$seed <- 42 

#============================================================
# Rattle timestamp: 2015-02-16 08:52:57 x86_64-w64-mingw32 

# Load the data.

crs$dataset <- read.csv("file:///C:/weather.csv", na.strings=c(".", "NA", "", "?"), strip.white=TRUE, encoding="UTF-8")

#============================================================
# Rattle timestamp: 2015-02-16 08:52:57 x86_64-w64-mingw32 

# Note the user selections. 

# Build the training/validate/test datasets.

set.seed(crv$seed) 
crs$nobs <- nrow(crs$dataset) # 366 observations 
crs$sample <- crs$train <- sample(nrow(crs$dataset), 0.7*crs$nobs) # 256 observations
crs$validate <- sample(setdiff(seq_len(nrow(crs$dataset)), crs$train), 0.15*crs$nobs) # 54 observations
crs$test <- setdiff(setdiff(seq_len(nrow(crs$dataset)), crs$train), crs$validate) # 56 observations

# The following variable selections have been noted.

crs$input <- c("MinTemp", "MaxTemp", "Rainfall", "Evaporation",
     "Sunshine", "WindGustDir", "WindGustSpeed", "WindDir9am",
     "WindDir3pm", "WindSpeed9am", "WindSpeed3pm", "Humidity9am",
     "Humidity3pm", "Pressure9am", "Pressure3pm", "Cloud9am",
     "Cloud3pm", "Temp9am", "Temp3pm", "RainToday")

crs$numeric <- c("MinTemp", "MaxTemp", "Rainfall", "Evaporation",
     "Sunshine", "WindGustSpeed", "WindSpeed9am", "WindSpeed3pm",
     "Humidity9am", "Humidity3pm", "Pressure9am", "Pressure3pm",
     "Cloud9am", "Cloud3pm", "Temp9am", "Temp3pm")

crs$categoric <- c("WindGustDir", "WindDir9am", "WindDir3pm", "RainToday")

crs$target  <- "RainTomorrow"
crs$risk    <- "RISK_MM"
crs$ident   <- "Date"
crs$ignore  <- "Location"
crs$weights <- NULL

#============================================================
# Rattle timestamp: 2015-02-16 08:53:04 x86_64-w64-mingw32 

# Decision Tree 

# The 'rpart' package provides the 'rpart' function.

require(rpart, quietly=TRUE)

# Reset the random number seed to obtain the same results each time.

set.seed(crv$seed)

# Build the Decision Tree model.

crs$rpart <- rpart(RainTomorrow ~ .,
    data=crs$dataset[crs$train, c(crs$input, crs$target)],
    method="class",
    parms=list(split="information"),
    control=rpart.control(usesurrogate=0, 
        maxsurrogate=0))

# Generate a textual view of the Decision Tree model.

print(crs$rpart)
printcp(crs$rpart)
cat("\n")

# Time taken: 0.02 secs

#============================================================
# Rattle timestamp: 2015-02-16 08:53:10 x86_64-w64-mingw32 

# Random Forest 

# The 'randomForest' package provides the 'randomForest' function.

require(randomForest, quietly=TRUE)

# Build the Random Forest model.

set.seed(crv$seed)
crs$rf <- randomForest(RainTomorrow ~ .,
      data=crs$dataset[crs$sample,c(crs$input, crs$target)], 
      ntree=500,
      mtry=4,
      importance=TRUE,
      na.action=na.roughfix,
      replace=FALSE)

# Generate textual output of 'Random Forest' model.

crs$rf

# The `pROC' package implements various AUC functions.

require(pROC, quietly=TRUE)

# Calculate the Area Under the Curve (AUC).

roc(crs$rf$y, as.numeric(crs$rf$predicted))

# Calculate the AUC Confidence Interval.

ci.auc(crs$rf$y, as.numeric(crs$rf$predicted))

# List the importance of the variables.

rn <- round(importance(crs$rf), 2)
rn[order(rn[,3], decreasing=TRUE),]

# Time taken: 0.33 secs

#============================================================
# Rattle timestamp: 2015-02-16 08:53:13 x86_64-w64-mingw32 

# Evaluate model performance. 

# Generate an Error Matrix for the Decision Tree model.

# Obtain the response from the Decision Tree model.

crs$pr <- predict(crs$rpart, newdata=crs$dataset[crs$validate, c(crs$input, crs$target)], type="class")

# Generate the confusion matrix showing counts.

table(crs$dataset[crs$validate, c(crs$input, crs$target)]$RainTomorrow, crs$pr,
        dnn=c("Actual", "Predicted"))

# Generate the confusion matrix showing proportions.

pcme <- function(actual, cl)
{
  x <- table(actual, cl)
  tbl <- cbind(round(x/length(actual), 2),
               Error=round(c(x[1,2]/sum(x[1,]),
                             x[2,1]/sum(x[2,])), 2))
  names(attr(tbl, "dimnames")) <- c("Actual", "Predicted")
  return(tbl)
};
pcme(crs$dataset[crs$validate, c(crs$input, crs$target)]$RainTomorrow, crs$pr)

# Calculate the overall error percentage.

overall <- function(x)
{
  if (nrow(x) == 2) 
    cat((x[1,2] + x[2,1]) / sum(x)) 
  else
    cat(1 - (x[1,rownames(x)]) / sum(x))
} 
overall(table(crs$pr, crs$dataset[crs$validate, c(crs$input, crs$target)]$RainTomorrow,  
        dnn=c("Predicted", "Actual")))

# Calculate the averaged class error percentage.

avgerr <- function(x) 
	cat(mean(c(x[1,2], x[2,1]) / apply(x, 1, sum))) 
avgerr(table(crs$pr, crs$dataset[crs$validate, c(crs$input, crs$target)]$RainTomorrow,  
        dnn=c("Predicted", "Actual")))

# Generate an Error Matrix for the Random Forest model.

# Obtain the response from the Random Forest model.

crs$pr <- predict(crs$rf, newdata=na.omit(crs$dataset[crs$validate, c(crs$input, crs$target)]))

# Generate the confusion matrix showing counts.

table(na.omit(crs$dataset[crs$validate, c(crs$input, crs$target)])$RainTomorrow, crs$pr,
        dnn=c("Actual", "Predicted"))

# Generate the confusion matrix showing proportions.

pcme <- function(actual, cl)
{
  x <- table(actual, cl)
  tbl <- cbind(round(x/length(actual), 2),
               Error=round(c(x[1,2]/sum(x[1,]),
                             x[2,1]/sum(x[2,])), 2))
  names(attr(tbl, "dimnames")) <- c("Actual", "Predicted")
  return(tbl)
};
pcme(na.omit(crs$dataset[crs$validate, c(crs$input, crs$target)])$RainTomorrow, crs$pr)

# Calculate the overall error percentage.

overall <- function(x)
{
  if (nrow(x) == 2) 
    cat((x[1,2] + x[2,1]) / sum(x)) 
  else
    cat(1 - (x[1,rownames(x)]) / sum(x))
} 
overall(table(crs$pr, na.omit(crs$dataset[crs$validate, c(crs$input, crs$target)])$RainTomorrow,  
        dnn=c("Predicted", "Actual")))

# Calculate the averaged class error percentage.

avgerr <- function(x) 
	cat(mean(c(x[1,2], x[2,1]) / apply(x, 1, sum))) 
avgerr(table(crs$pr, na.omit(crs$dataset[crs$validate, c(crs$input, crs$target)])$RainTomorrow,  
        dnn=c("Predicted", "Actual")))