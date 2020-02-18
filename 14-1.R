
library(dplyr)

data(iris)
sub_iris <- select(iris, Petal.Length, Petal.Width)
head(sub_iris)

head(filter(iris, Petal.Length < 1 | Petal.Width <1))
head(filter(iris,  Petal.Length == 1.4 & Petal.Width == 0.2))

head(arrange(iris, desc(Petal.Length)))
head(arrange(iris, desc(Petal.Length), Petal.Width))
head(arrange(iris, Petal.Width, desc(Petal.Length)))

head(mutate(iris, Petal.Length.new = Petal.Length/ 10))

by_Petal.Width <- group_by(iris, Petal.Width)
head(by_Petal.Width)

summarise(by_Petal.Width, n=n(), mean(Petal.Width))

df_by_Petal.Width <- as.data.frame(by_Petal.Width)
str(df_by_Petal.Width)





