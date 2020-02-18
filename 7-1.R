
data(iris)
index <- 1:nrow(iris)
np <- ceiling(0.1*nrow(iris))        # 使用10%資料
idx <- sample(1:nrow(iris),np)

irisSample <- iris[idx,]
irisSample$Species <- NULL
hc <- hclust(dist(irisSample), method="single")
plot(hc, labels=iris$Species[idx])

rect.hclust(hc, k=3)

