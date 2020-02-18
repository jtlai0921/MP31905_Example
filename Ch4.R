demo(graphics)
demo(image)

x <- sin(1:20)
plot(x, type="l",main="Sin Plot", xlab="X",ylab="Y")

 
x <- sin(1:20)
plot(x, type="l", xlab="X",ylab="Y")
title(main="Sin Plot",sub="圖4-2:低階繪圖函數圖")

 
plot(2, 2)
pts <- locator(n = 3)    #使用者可在圖形中以滑鼠左鍵點選三個
                         #座標點
pts                      #點選完成後，pts 的值為

x <- c(1, 3, 5, 7, 8, 9, 3, 6, 7, 2)
y <- c(5, 3, 5, 8, 2, 1, 4, 3, 4, 7)
plot(x, y)
sel <- identify(x, y) #點選滑鼠左鍵10次
 
x <- c(1, 3, 5, 7, 8, 9, 3, 6, 7, 2)
y <- c(5, 3, 5, 8, 2, 1, 4, 3, 4, 7)
plot(x, y)
sel <- identify(x, y,"MY LBAELS") #按滑鼠左鍵約點選圖中間處
                                    #並點選滑鼠右鍵結束
x.sel <- x[sel]
y.sel <- y[sel]
x.sel 
y.sel 

par() 
x <- c(5, 3, 5, 8, 2, 1, 4, 3, 4, 7)
par(col=4, lty=2)
plot(x, type="l", xlab="X",ylab="Y")

par(mfrow=c(1,2))
par(mar=c(5, 4, 4, 2))
par(col=4, lty=1)

plot(x, type="l", xlab="X",ylab="Y")
barplot(x, xlab="X",ylab="Y")

summary(iris)

par(mfrow=c(1,1)) 
y=c(170,170,171,172)
hist(y,col='grey')

library(lattice)
histogram(y)

y1=c(165,166,167,167,175,176,177,178,179,180)
median(y1,na.rm = TRUE) # 中位數

max(y1)                 # 最大值
min(y1)                 # 最小值
max(y1)-min(y1)         # 全距
range(y1)

quantile(y1,0.25)       # 第一個四分位數
quantile(y1,0.75)       # 第三個四分位數
IQR(y1)                 # 四分位數間距
boxplot(as.data.frame(y1), main = "boxplot(*, horizontal = FALSE)", horizontal = FALSE)

y1=c(165,166,167,167,175,176,177,178,179,180)

mean(y1,na.rm = TRUE)   # 平均值
median(y1,na.rm = TRUE) # 中位數
var(y1)                 # 變異數 
sd(y1)                  # 標準差

table(y1)               # 出現次數
which.max(table(y1))    # 眾數及其排列位置

cor(y1,y1)              # 相關係數
cor(y1,-y1)

setwd("c:/")
A10 <- read.table(file="grade.csv",header=TRUE,sep=",",encoding="Big5")
A10 <- as.matrix(A10)
NoHeader.A10 <- matrix(A10, ncol = ncol(A10), dimnames = NULL)

X=A10[,2]
Y=A10[,3]
cor(Y,X)

Lm_model <- lm(Y ~ X)
Lm_model

cf <- coef(lm(Y ~ X)) 
cf 

lm_function <- function(x) {y <- cf[1]+cf[2]*x; return (y) } 
Y_output <- sapply(X,lm_function)

abs(Y-Y_output)

par(mfrow=c(1,1))
par(mar=c(5, 4, 4, 2))

par(col="black")
plot(X,Y)
abline(lm(Y ~ X))

par(col="blue")
points(X,Y_output)




























