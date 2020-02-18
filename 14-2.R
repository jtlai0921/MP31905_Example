# Please run this program in SparkR
if (nchar(Sys.getenv("SPARK_HOME")) < 1) {
  Sys.setenv(SPARK_HOME = "/usr/local/spark")
}

library(SparkR, lib.loc = c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib")))

# Initialize SparkSession
sparkR.session(appName = "SparkR-example")

# Create a simple local data.frame
localDF <- data.frame(name=c("John", "Mary", "Sara"), age=c(19, 22, 18))

# Convert local data frame to a SparkDataFrame
df <- createDataFrame(localDF)

# Print its schema
printSchema(df)
# root
#  |-- name: string (nullable = true)
#  |-- age: double (nullable = true)
str(df)

local_df <- collect(df)
str(local_df)

sparkR.session.stop()

df

local_df

localDF