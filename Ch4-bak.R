demo(graphics)
demo(image)

y <- sin(1:20)
plot(y, type="l",main="Sin Plot", xlab="X",ylab="Y")

 
y <- sin(1:20)
plot(y, type="l", xlab="X",ylab="Y")
title(main="Sin Plot",sub="��4-2:�C��ø�Ϩ�ƹ�")

 
plot(2, 2)
pts <- locator(n = 3)    #�ϥΪ̥i�b�ϧΤ��H�ƹ������I��T��
                         #�y���I
pts                      #�I�粒����Apts ���Ȭ�

x <- c(1, 3, 5, 7, 8, 9, 3, 6, 7, 2)
y <- c(5, 3, 5, 8, 2, 1, 4, 3, 4, 7)
plot(x, y)
sel <- identify(x, y) #�I��ƹ�����10��
 
x <- c(1, 3, 5, 7, 8, 9, 3, 6, 7, 2)
y <- c(5, 3, 5, 8, 2, 1, 4, 3, 4, 7)
plot(x, y)
sel <- identify(x, y,"MY LBAELS") #���ƹ�������I��Ϥ����B
                                    #���I��ƹ��k�䵲��
x.sel <- x[sel]
y.sel <- y[sel]
x.sel 
y.sel 

 
par()

y <- c(5, 3, 5, 8, 2, 1, 4, 3, 4, 7)
par(col=4, lty=4)
plot(y, type="l", xlab="X",ylab="Y")
 
y=c(170,170,171,172)
hist(y,col='grey')

library(lattice)
histogram(y)

y1=c(165,166,167,167,175,176,177,178,179,180)
median(y1,na.rm = TRUE) # �����

max(y1)                 # �̤j��
min(y1)                 # �̤p��
max(y1)-min(y1)         # ���Z
range(y1)

quantile(y1,0.25)       # �Ĥ@�ӥ|�����
quantile(y1,0.75)       # �ĤT�ӥ|�����
IQR(y1)                 # �|����ƶ��Z
boxplot(as.data.frame(y1), main = "boxplot(*, horizontal = FALSE)", horizontal = FALSE)

y1=c(165,166,167,167,175,176,177,178,179,180)

mean(y1,na.rm = TRUE)   # ������
median(y1,na.rm = TRUE) # �����
var(y1)                 # �ܲ��� 
sd(y1)                  # �зǮt

table(y1)               # �X�{����
which.max(table(y1))    # ���ƤΨ�ƦC��m

cor(y1,y1)              # �����Y��
cor(y1,-y1)

setwd("D:/")
A10 <- read.table(file="c-1.csv",header=TRUE,sep=",")
A10 <- as.matrix(A10)
NoHeader.A10 <- matrix(A10, ncol = ncol(A10), dimnames = NULL)

X=A10[,2]
Y=A10[,3]
cor(Y,X)

Lm_model <- lm(Y ~ X)
Lm_model

z=3
cf <- coef(lm(Y ~ X))

lm_function <- function(x) {y <- cf[1]+cf[2]*x; z=2; print(z); return (y) }
sapply(X,lm_function)
print(z)


























