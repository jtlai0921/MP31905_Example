# Free memory
rm(list = ls())
gc()

# Please run this program in SparkR
if (nchar(Sys.getenv("SPARK_HOME")) < 1) {
  Sys.setenv(SPARK_HOME = "/usr/local/spark")
}

library(SparkR, lib.loc = c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib")))


sparkR.session(master = "spark://192.168.244.151:7077", sparkConfig = list(spark.driver.memory = "20g"))

allyearsCsvPath <- "/home/spark/allyears_10.csv"

#  Directly create a SparkDataFrame from the source data
ptm <- proc.time()
allyearsDF <- read.df(allyearsCsvPath, source = "csv", header = "true")
proc.time()-ptm

#ptm <- proc.time()
#nrow(irisDF)
#proc.time()-ptm

#cache(allyearsDF)

createOrReplaceTempView(allyearsDF, "allyearsTable")

ptm <- proc.time()
sql_selectDF <- sql("SELECT * FROM allyearsTable")
head(sql_selectDF)
proc.time()-ptm

ptm <- proc.time()
new_dfx1 <- sql("SELECT Year, DayofMonth, DayOfWeek, ArrTime, DepDelay, Origin, Dest FROM allyearsTable 
                WHERE ArrDelay <= 0 AND Distance = 337")
#count(new_dfx1)
head(new_dfx1)
proc.time()-ptm

ptm <- proc.time()
dfy1 <- collect(new_dfx1)
proc.time()-ptm

# Stop the SparkSession now
sparkR.session.stop()