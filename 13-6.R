## Required path for R+Hadoop
Sys.setenv(
  HIVE_NAME= '/usr/local/hive',
  HADOOP_HOME='/usr/local/hadoop-2.5.1',
  HADOOP_CMD='/usr/local/hadoop-2.5.1/bin/hadoop',
  HADOOP_CONF_DIR='/usr/local/hadoop-2.5.1/etc/hadoop',
  HADOOP_STREAMING ='/usr/local/hadoop-2.5.1/share/hadoop/tools/lib/hadoop-streaming-2.5.1.jar')

## laoding the libraries
library('rhdfs')
library('rmr2')
library('rhbase')
library('RHive')

## initialize hdfs
hdfs.init()

rhive.init(hiveHome="/usr/local/hive",hiveLib="/usr/local/hive/lib",hadoopHome="/usr/local/hadoop-2.5.1")

rhive.connect('master', hiveServer2=TRUE)
rhive.query('show databases')

rhive.list.tables()

df1=rhive.query('SELECT * from gdp')
df1

#library(wordcloud)

#words1=as.matrix(df1[,3])
#m1=as.matrix(df1[,4])

#wordcloud(words1, m1)

rhive.drop.table('gdp')

