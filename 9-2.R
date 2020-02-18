
#install.packages("ANN")   用本機的zip檔案來安裝程式套件
library(ANN)

#use the command demo(ANN) to see how dataANN was created
data("dataANN")

#Example
ANNGA(x =input,
y =output,
design =c(1, 3, 1),
population =100,
mutation = 0.3,
crossover = 0.7,
maxGen =100,
error =0.001)


