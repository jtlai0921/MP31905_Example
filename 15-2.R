# Free memory
rm(list = ls())
gc()

# Please run this program in SparkR
if (nchar(Sys.getenv("SPARK_HOME")) < 1) {
  Sys.setenv(SPARK_HOME = "/usr/local/spark")
}

library(SparkR, lib.loc = c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib")))

sparkR.session(appName = "SparkR-Data Analyze")
data(iris)
data2=iris
data2$Species <- NULL

sp_data2=as.DataFrame(data2)

kmeansModel <- spark.kmeans(sp_data2, ~., k=2)

# Get fitted result from the k-means model
fitted_kmeans=fitted(kmeansModel)
head(fitted_kmeans)

kmeans.cluster=as.data.frame(fitted_kmeans)

data2=collect(sp_data2)
data2$cluster<-kmeans.cluster$prediction #分群寫入新欄位

data2$cluster=factor(data2$cluster)

###
library("rpart")
set.seed(10)
np = ceiling(0.1*nrow(data2))         # 10% 為測試資料

test.index = base:::sample(1:nrow(data2),np)

data2.testdata = data2[test.index,]		
data2.traindata = data2[-test.index,]	 

data2.tree = rpart(cluster ~., method="class",  data=data2.traindata )

#data2.tree
#summary(data2.tree)

cluster.traindata = data2$cluster[-test.index]
train.predict=factor(predict(data2.tree, data2.traindata,type='class'), levels=levels(cluster.traindata))
table.traindata =table(cluster.traindata,train.predict)
table.traindata
correct.traindata=sum(diag(table.traindata))/sum(table.traindata)*100
correct.traindata

cluster.testdata = data2$cluster[test.index]
test.predict=factor(predict(data2.tree, data2.testdata,
                            type='class'), levels=levels(cluster.testdata))
table.testdata  =table(cluster.testdata,test.predict)
table.testdata
correct.testdata=sum(diag(table.testdata))/sum(table.testdata)*100
correct.testdata

sparkR.session.stop()
