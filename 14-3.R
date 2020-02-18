# Please run this program in SparkR
if (nchar(Sys.getenv("SPARK_HOME")) < 1) {
  Sys.setenv(SPARK_HOME = "/usr/local/spark")
}

library(SparkR, lib.loc = c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib")))

## Initialize SparkSession
sparkR.session(appName = "SparkR-data-manipulation-example")

irisCsvPath    <- "/home/spark/iris_1.csv"

#  Directly create a SparkDataFrame from the source data
irisDF <- read.df(irisCsvPath, source = "csv", header = "true")

# Print the schema of this SparkDataFrame
printSchema(irisDF)

# Cache the SparkDataFrame
cache(irisDF)

# Print the first 6 rows of the SparkDataFrame
showDF(irisDF, numRows = 6) ## Or
head(irisDF)

# Show the column names in the SparkDataFrame
columns(irisDF)

# Show the number of rows in the SparkDataFrame
count(irisDF)

newirisCsvPath <- "/home/spark/iris_New"

#  Convert to R data.frame 
local_irisDF <- collect(irisDF)

str(local_irisDF)
local_irisDF$Sepal_Length[1] <- 0.1

# Convert local data frame to a SparkDataFrame
newirisDF <- createDataFrame(local_irisDF)

write.df(newirisDF, path = newirisCsvPath, source = "csv", header="true", mode = "overwrite")

irisNewDF <- read.df(newirisCsvPath, source = "csv", header = "true")
str(irisNewDF)



# Select specific columns
head(select(irisDF, "Petal_Length", "Petal_Width"))
head(select(irisDF, irisDF$Petal_Length, irisDF$Petal_Width))

#head(filter(irisDF, "Petal_Length < 1.3"))
head(where(irisDF, irisDF$Petal_Length < 1.3 | irisDF$Petal_Width <1))

head(arrange(irisDF, desc(irisDF$Petal_Length)))
head(arrange(irisDF, desc(irisDF$Petal_Length), irisDF$Petal_Width))

head(mutate(irisDF, Petal_Length.new = irisDF$Petal_Length/10))
head(select(irisDF, irisDF$Petal_Length, irisDF$Petal_Length/10))

head(count(groupBy(irisDF, "Species")))
head(summarize(groupBy(irisDF, irisDF$Species), count = n(irisDF$Species)))

waiting_counts <- summarize(groupBy(irisDF, irisDF$Species), count = n(irisDF$Species))
head(arrange(waiting_counts, desc(waiting_counts$count)))

waiting_counts <- summarize(groupBy(irisDF, irisDF$Petal_Width, irisDF$Petal_Length), count = n(irisDF$Species))
head(arrange(waiting_counts, desc(waiting_counts$count)))

head(summarize(groupBy(irisDF, irisDF$Petal_Width, irisDF$Petal_Length),avg(irisDF$Sepal_Length)))

library(magrittr)
groupBy(irisDF, irisDF$Petal_Width, irisDF$Petal_Length) %>%
  summarize(avg(irisDF$Sepal_Length)) -> summ_irisDF
head(summ_irisDF)

# Using SQL to select columns of data
# First, register the flights SparkDataFrame as a table
irisDF <- read.df(irisCsvPath, source = "csv", header = "true")

createOrReplaceTempView(irisDF, "irisTable")

sql_selectDF <- sql("SELECT Petal_Length, Petal_Width FROM irisTable")
head(sql_selectDF)

sql_selectDF <- sql("SELECT * FROM irisTable WHERE Petal_Length <1.3 OR Petal_Width < 1 ")
head(sql_selectDF)

sql_selectDF <- sql("SELECT Species, COUNT(Species) FROM irisTable GROUP BY Species")
head(sql_selectDF)

sql_selectDF <- sql("SELECT Species, COUNT(Species) AS sum_species FROM irisTable GROUP BY Species")
head(sql_selectDF)

sql_selectDF <- sql("SELECT Petal_Length, Petal_Length/10 AS New_petal_length FROM irisTable")
head(sql_selectDF)

sql_selectDF <- sql("SELECT Petal_Width, Petal_Length, AVG(Petal_Length) AS avg_Petal_Length FROM irisTable GROUP BY Petal_Width, Petal_Length")
head(sql_selectDF)

sql_selectDF <- sql("SELECT Petal_Width, Petal_Length FROM irisTable ORDER BY Petal_Width ASC")
head(sql_selectDF)

sql_selectDF <- sql("SELECT Petal_Width, Petal_Length FROM irisTable ORDER BY Petal_Width DESC")
head(sql_selectDF)

# Use collect to create a local R data frame
#local_df <- collect(sql_selectDF)
#head(selectDF)

# Stop the SparkSession now
sparkR.session.stop()