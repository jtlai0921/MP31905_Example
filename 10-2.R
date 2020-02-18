
library(arules)
# free memory
rm(list = ls())
gc()

data(Titanic)
str(Titanic)
df <- as.data.frame(Titanic)

titanic.new <- NULL
for(i in 1:4) {
   titanic.new <- cbind(titanic.new, rep(as.character(df[,i]),df$Freq))
}

titanic.new <- as.data.frame(titanic.new)
names(titanic.new) <- names(df)[1:4]
str(titanic.new)
summary(titanic.new)

# find association rules with default settings
titanic_rules.all <- apriori(titanic.new)
inspect(titanic_rules.all)


# rules with rhs containing "Survived" only
rules <- apriori(titanic.new, control = list(verbose=F),
                 parameter = list(minlen=2, supp=0.005, conf=0.8),
                 appearance = list(rhs=c("Survived=No", "Survived=Yes"),
                                   default="lhs"))
quality(rules) <- round(quality(rules), digits=3)
rules.sorted <- sort(rules, by="lift")

inspect(rules.sorted)

# find redundant rules
subset.matrix <- is.subset(rules.sorted, rules.sorted)
subset.matrix[lower.tri(subset.matrix, diag=T)] <- NA
redundant <- colSums(subset.matrix, na.rm=T) >= 1
which(redundant)

# remove redundant rules
rules.pruned <- rules.sorted[!redundant]
inspect(rules.pruned)

rules <- apriori(titanic.new, 
                 parameter = list(minlen=3, supp=0.002, conf=0.2),
                 appearance = list(rhs=c("Survived=Yes"),
                                   lhs=c("Class=1st", "Class=2nd", "Class=3rd",
                                         "Age=Child", "Age=Adult"),
                                   default="none"), 
                 control = list(verbose=F))
rules.sorted <- sort(rules, by="confidence")
inspect(rules.sorted)

library(arulesViz)
plot(titanic_rules.all)
plot(titanic_rules.all, shading="order", control=list(main = "Two-key plot",col=rainbow(5)))


