a <- c(1,2,3)
x <- a+2
x

a <- c(1,2,3)
(x <- a+2)

{a <- c(1,2,3);x=a+2}
x


x <- 6
if (x>5) y=2 else y=4
y

X <- 3
if (X<5) Y=10
Y

X <- 3
Y <- 1
if (X<5 && Y<5) {Y <- 10; Z <- 5}
Y

Z

X <- 20
Y=ifelse(X>5, 2, 3)
Y

X <- 1
switch(X, 5, sum(1:10), rnorm(5))

X <- 2
switch(X, 5, sum(1:10), rnorm(5))

X <- 3
switch(X, 5, sum(1:10), rnorm(5))

X <- 4
switch(X, 5, sum(1:10), rnorm(5))    #礚肚

Y <- 1
switch(Y, juice="Apple", meat="Pork")

Y <- "juice"
switch(Y, juice="Apple", meat="Pork")

X <- 0
for(i in 1:5) X <- X+i
X

X <- 0
Y <- 0
for(i in 1:5) { X<- X+i; Y <- i^2}
X
Y

sum <- 0
i <- 1
while (i <= 10) {sum <- sum + i; i <- i + 1}
sum


sum <- 0
i <- 1
repeat {
 sum <- sum + i
 i <- i + 1
 if ( i > 10 ) break
 }
sum


sum <- 0
for (i in 1:50)
 {                       
 if ( i %% 2 == 0 ) next # %% 琌―案计
 sum <- sum + i           # 璝 i 琌案计玥ぃ磅︽sum <- sum + i
 }
sum


X <- array(1:24, dim = c(4,6))
X

apply(X,1,sum)

X <- array(1:24, dim = c(4,6))
X
 
apply(X,2,sum)

X <- list(a=1:10, b=exp(-1:1))
lapply(X,sum)

X <- list(a=1:10, b=exp(-1:1))
sapply(X,sum)
        
X <- 1
myfun <- function(X) { Y <- X+2; return (Y) }
myfun(X)


X <- 2        # 块ま计肚籔箇砞ぃ
myfun <- function(X=1) { Y <- X+2; return (Y) }
myfun(X)


myfun <- function(X=1) { Y <- X+2; return (Y) }
myfun()    # 礚块ま计玥ㄏノ箇砞X=1


x <- 1
myfun <- function(x) { x <- 2; print(x) } 
myfun(x)

x          # 礚猭э跑场ン x 


x <- 1
myfun <- function(x) { x <<- 2; print(x) } 
myfun(x)    

x          # 场ン x э跑

