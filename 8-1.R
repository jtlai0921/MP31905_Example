install.packages("GA")
library("GA")

f <- function(x)  25-x*x
min <- -5
max <- 5
curve(f, min, max)

fitness <- function(x) f(x)
GA <- ga(type="real-valued",
fitness=fitness, 
min=min, 
max=max, 
popSize = 50,
pcrossover = 0.8,
pmutation = 0.1,
elitism = 10,
monitor = gaMonitor,
maxiter = 100)

plot(GA)

