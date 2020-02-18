# To grow a tree, use
# rpart (formula, data=, method=, control=)
# where:
#  
# formula is in the format: outcome ~ predictor1+predictor2+predictor3+ect. 
# data= specifies the dataframe 
# method= "class" for a classification tree "anova" for a regression tree 
# control= optional parameters for controlling tree growth. 
#          For example, control=rpart.control(minsplit=30, cp=0.001) requires that 
#                       the minimum number of observations in a node be 30 before attempting 
#                       a split and that a split must decrease the overall lack of fit by a 
#                       factor of 0.001 (cost complexity factor) before being attempted. 


############################################################################################
#  IRIS data (?ܼƼƥ?: 5, ?[???ȼƥ?(???Ƶ???): 150) 

#  (C1) SepalLength : ?Ḱ????  --- ?????ܼ? X1
#  (C2) SepalWidth :  ?Ḱ?e??  --- ?????ܼ? X2
#  (C3) PetalLength : ??ä????  --- ?????ܼ? X3
#  (C4) PetalWidth :  ??ä?e??  --- ?????ܼ? X4
#  (C5) Species :     ?~??      --- ��?ܼ?   Y
#############################################################################################
install.packages("rpart")
library(rpart)

data(iris)

np = ceiling(0.1*nrow(iris))        # 10% ?????ո???
np

test.index = sample(1:nrow(iris),np)

iris.testdata = iris[test.index,]		# ???ո???
iris.traindata = iris[-test.index,]	        # ?V?m????
iris.tree = rpart(Species ~  Sepal.Length + Sepal.Width +Petal.Length + Petal.Width, method="class",  data=iris.traindata )
 			
iris.tree

summary(iris.tree)
par(mar=rep(0.1,4))
plot(iris.tree) ; text(iris.tree)

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

