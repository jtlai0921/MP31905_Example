
install.packages("C50")

library(C50)

remove.packages("C50")

library(ANN)

installed.packages()

library()

update.packages()

x <- 10
x


X <- x^2
X

z <- sqrt(X)
z


x <- 10
x

mode(x)

length(x)

x <- 10; y <- x^2; z <- sqrt(y)
z

x <- 10        #俱计计
x

mode(x)

length(x)

y <- 10.9       #龟计计
y
 
mode(y)

length(y)

z <- T          #呸胯
z

mode(z)

length(z)

a <- "Hello"    #ゅ
a
mode(a)
length(a)

z <- 4+2i       #狡计
z
mode(z)
length(z)


V <- c(10, 5, 3.1, 6.4, 9.2, 21.7)
V
length(V)
mode(V)

assign("V", c(10, 5, 3.1, 6.4, 9.2, 21.7))
V
length(V)
mode(V)

V <- c(10, 5, NA, 6.4, 9.2, 21.7)
V
V[2]
V <- c(1,-2,0)
V/0

V <- NULL
length(V)

V2=1:10
V2
V2[1]
V2[2:4]

X <- 1:24
dim(X) <- c(3,4,2)
X

dim(X) <- c(4,6)
X
 
X <- array(1:24, dim = c(3,4,2))
X

X <- array(1:24, dim = c(4,6))
X

X <- array(0, dim = c(3,4,2))
X

X1 <- c(1,2,3,4)
X2 <- c(5,6,7,8)
X  <- rbind(X1,X2)
X
 
X <- matrix(1:24, nrow=4, ncol=6, byrow=TRUE)
X

X1 <- c(1,2,3)
X2 <- c(4,5,6)
X3 <- c(7,8,9)
X <- cbind(X1,X2,X3)
X

Y=t(X)
Y

m <- nrow(Y)
m

n <- ncol(Y)
n


X[,1]
X[2,]
X[c(1,3),]

X[-1,]
X[,-2]

eigen(Y)

z <- Y%*%X
z

colnames(z) <- c("c1","c2","c3")
z

rownames(z) <- c("r1","r2","r3")
z
 
id <- c(1, 2, 3, 4)
age <- c(25, 30, 35, 40)
sex <- c("Male", "Male", "Female", "Female")
pay <-c (30000, 40000, 45000, 50000)
X.dataframe <- data.frame(id, age, sex, pay)
X.dataframe 
 
X.dataframe[3,2] 

X.dataframe$age

X.dataframe[2]
 
edit(X.dataframe)
X.dataframe <- edit(X.dataframe)

sex <- factor(c("╧", "", "╧", "╧", ""))
sex

id <- c(1, 2, 3)
sex <- c("Male", "Male", "Female")
pay <-c (30000, 40000, 45000)
Y.dataframe <- data.frame(id, sex, pay)

gender <- factor(c("╧", "╧", ""))

Paul.Family <- list(name="Paul", wife="Iris", no.kids=3, kids.age=c(25,28,30), gender, Y.dataframe)
Paul.Family
Paul.Family$kids.age
Paul.Family[[4]]
Paul.Family[4]
Paul.Family$kids.age[2]
Paul.Family[[4]][2]

id <- c(1, 2, 3, 4)
x <- data.frame(id)
x

matrix.x=as.matrix(x)
matrix.x

vector.x=as.vector(matrix.x)
vector.x


