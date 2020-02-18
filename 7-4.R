install.packages("NbClust")
library(NbClust)

data(iris)

data <-iris[,-c(5)]


NbClust(data, distance = "euclidean", min.nc=2, max.nc=6, method = "kmeans", index = "all")







