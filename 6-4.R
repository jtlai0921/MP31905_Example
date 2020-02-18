install.packages("C50")
install.packages("stringr")

library(C50)
library(stringr)

data(iris)

c=C5.0Control(subset = FALSE,
              bands = 0,
              winnow = FALSE,
              noGlobalPruning = FALSE,
              CF = 0.25,
              minCases = 2,
              fuzzyThreshold = FALSE,
              sample = 0.9,
              seed = sample.int(4096, size = 1) - 1L,
              earlyStopping = TRUE,
              label = "Species")


iris_treeModel <- C5.0(x = iris[, -5], y = iris$Species,
                  control =c)

summary(iris_treeModel)

# Can't use ) in str_locate_all()

# x=str_locate_all(iris_treeModel$output,"%)")
# y=substr(iris_treeModel$output,x[[1]][2]-4,x[[1]][2]-1)

tt=as.character(iris_treeModel$output)
x=str_locate_all(tt,"<<")
y=substr(tt,x[[1]][2]-9,x[[1]][2]-6)

test.error=as.numeric(y)
test.correct=100-test.error
test.correct





