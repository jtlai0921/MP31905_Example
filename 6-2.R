# To grow a tree, use
# rpart (formula, data=, method=, control=)
# where:
#  
# formula is in the format: outcome ~ predictor1+predictor2+predictor3+ect. 
# data= specifies the dataframe 
# method= "class" for a classification tree "anova" for a regression tree 
# control= optional parameters for controlling tree growth. 
#          For example, control=rpart.control(minsplit=5, cp=0.0001) requires that 
#                       the minimum number of observations in a node be 30 before attempting 
#                       a split and that a split must decrease the overall lack of fit by a 
#                       factor of 0.0001 (cost complexity factor) before being attempted. 


############################################################################################
#  IRIS data (變數數目: 5, 觀察值數目(資料筆數): 150) 

#  (C1) SepalLength :  花萼長度  --- 解釋變數 X1
#  (C2) SepalWidth :   花萼寬度  --- 解釋變數 X2
#  (C3) PetalLength :  花瓣長度  --- 解釋變數 X3
#  (C4) PetalWidth :   花瓣寬度  --- 解釋變數 X4
#  (C5) Species :      品種      --- 應變數 Y
#############################################################################################
install.packages("rpart")
library(rpart)

data(iris)

np = ceiling(0.1*nrow(iris))        # 10% 為測試資料
np

test.index = sample(1:nrow(iris),np)

iris.testdata = iris[test.index,]		# 測試資料
iris.traindata = iris[-test.index,]	        # 訓練資料

iris.tree = rpart(Species ~  Sepal.Length + Sepal.Width +Petal.Length + Petal.Width, method="class",  data=iris.traindata, control=rpart.control(minsplit=5, cp=0.0001, maxdepth=30) )
 			
species.traindata = iris$Species[-test.index]
train.predict=factor(predict(iris.tree, iris.traindata,
	type='class'), levels=levels(species.traindata))

table.traindata =table(species.traindata,train.predict)
table.traindata
correct.traindata=sum(diag(table.traindata))/sum(table.traindata)*100
correct.traindata

species.testdata = iris$Species[test.index]
test.predict=factor(predict(iris.tree, iris.testdata,
		type='class'), levels=levels(species.testdata)) 
table.testdata  =table(species.testdata,test.predict)
table.testdata
correct.testdata=sum(diag(table.testdata))/sum(table.testdata)*100
correct.testdata

iris.tree
