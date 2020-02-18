install.packages("e1071")
library("e1071")  

data(iris)


x<-rbind(iris$Sepal.Length, iris$Sepal.Width, iris$Petal.Length, iris$Petal.Width)
x<-t(x)
result<-cmeans(x,m=2,centers=3,iter.max=500,verbose=TRUE,method="cmeans")

print(result)

table(iris$Species, result$cluster)

