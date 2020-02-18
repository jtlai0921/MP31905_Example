install.packages("neuralnet")

library("neuralnet")

Var1 <- runif(100, 0, 100)
sqrt.data <- data.frame(Var1, Sqrt=sqrt(Var1))
net.sqrt <- neuralnet(Sqrt~Var1, sqrt.data, hidden=10,threshold=0.01)
print(net.sqrt)

plot(net.sqrt)

expected.output <- as.data.frame(sqrt((1:10)^2))
#expected.output=cbind(expected.output)

testdata <- as.data.frame((1:10)^2)
nn.result <- compute(net.sqrt, testdata)
print(nn.result)


install.packages("DMwR")
library(DMwR)
regr.eval(expected.output,nn.result$net.result[,1],stats=c('mae','rmse'))
