#Load RJDBC
library(RJDBC)

drv <- JDBC("org.apache.cassandra.cql.jdbc.CassandraDriver",list.files("/usr/local/apache-cassandra-3.7/lib",pattern = "jar$", full.names = TRUE))
conn <- dbConnect(drv, "jdbc:cassandra://192.168.244.150:9160/mykeyspace")

#res <- dbGetQuery(conn, "select * from mykeyspace.student")
res <- dbGetQuery(conn, "select * from student")
head(res)

res <- dbGetQuery(conn, "select count(*) from student")
res
