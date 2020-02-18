if (nchar(Sys.getenv("SPARK_HOME")) < 1) {
  Sys.setenv(SPARK_HOME = "/usr/local/spark")
}

library(SparkR, lib.loc = c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib")))

Sys.setenv('SPARKR_SUBMIT_ARGS'='"--packages" "com.datastax.spark:spark-cassandra-connector:2.0.0-M2-s_2.11" "--conf" "spark.cassandra.connection.host=210.59.244.150" "--jars" "/usr/local/spark/spark-cassandra-connector-2.0.0-M2-s_2.11.jar" "sparkr-shell"')

sparkR.session(appName = "SparkR-Cassandra")

people <-read.df("192.168.244.150", source = "org.apache.spark.sql.cassandra", keyspace = "mykeyspace", table = "student")
head(people)
str(people)

createOrReplaceTempView(people, "peopleTable")

sql_selectDF <- sql("SELECT no, class FROM peopleTable")
head(sql_selectDF)

sparkR.session.stop()