setwd("c:/")
getwd()

setwd("c:/")
X <- read.table("X.csv",sep=",",header=TRUE)
X
X$age
X[1,2]


setwd("c:/")
X <- read.table("X.csv",sep=",",header=FALSE)
X

setwd("c:/")
X <- read.csv("X.csv", header=TRUE,encoding="Big5")
X

X <- read.csv("X.csv", header=FALSE,encoding="UTF-8")
X

X <- read.csv("https://raw.githubusercontent.com/uiuc-cse/data-fa14/gh-pages/data/iris.csv", header = TRUE, encoding = "UTF-8")
X

X <- read.table("X.txt",header=TRUE)
X

X <- scan("")
X

my=scan(file="",what=list(name="",pay=integer(0),sex=""))
mode(my)


X <- scan("X1.csv", sep=",")
X
 
X <- scan("X1.txt")
X
 
write.table(X,"C:/X_File.csv",row.names=FALSE,col.names=FALSE,sep=",")

write.table(X,"C:/X_File.csv",row.names=FALSE,col.names=TRUE,sep=",",fileEncoding="Big5")

data()

data(iris)
iris
 
str(iris)
 
setwd("c:/")
data(iris)
save(iris,file="iris.RData")

getwd()
load("iris.RData", .GlobalEnv)

install.packages("RODBC")
library("RODBC")

db <- odbcConnect(dsn="test", uid="test", pwd="test")

query <- "SELECT * FROM iris"
df <- sqlQuery(db, query)
df
str(df)
head(df)
tail(df)

odbcClose(db)

install.packages("XLConnect")
library("XLConnect")
setwd("c:/")
data("iris")

wb <- loadWorkbook("XLDemo.xlsx", create = TRUE)

createSheet(wb, name = "iris")

createName(wb, name = "iris", formula = "iris!$A$1")

writeNamedRegion(wb, iris, name = "iris")

saveWorkbook(wb)

startRow=5
startCol=1
endRow=6
endCol = 5

read_data <- readWorksheetFromFile("XLDemo.xlsx", sheet = 1, header = F, 
             startRow, startCol, endRow, endCol)

writeWorksheetToFile("XLTest.xls", data=read_data, sheet="Test",startRow= 1, startCol= 1, header=FALSE)

install.packages("openxlsx")
library("openxlsx")
setwd("c:/")

## setup a workbook with 2 worksheets
wb <- createWorkbook()

addWorksheet(wb = wb, sheetName = "iris", gridLines = FALSE)
writeDataTable(wb = wb, sheet = 1, x = iris)

addWorksheet(wb = wb, sheetName = "mtcars (Sheet 2)", gridLines = TRUE)
writeDataTable(wb = wb, sheet = 2, x = mtcars)

saveWorkbook(wb, "X2.xlsx", overwrite = TRUE)

#wb <- read.xlsx("X2.xlsx", sheet = 1)

wb <- loadWorkbook("C:/X2.xlsx")
writeData(wb, 1, "cars", startCol = 2, startRow = 2)
saveWorkbook(wb, "X3.xlsx", overwrite = TRUE)

