## Required path for R+Hadoop
Sys.setenv(
  HIVE_HOME= '/usr/local/hive',
  HADOOP_HOME='/usr/local/hadoop-2.5.1',
  HADOOP_CMD='/usr/local/hadoop-2.5.1/bin/hadoop',
  HADOOP_CONF_DIR='/usr/local/hadoop-2.5.1/etc/hadoop',
  HADOOP_STREAMING ='/usr/local/hadoop-2.5.1/share/hadoop/tools/lib/hadoop-streaming-2.5.1.jar')

## laoding the libraries
library('rhdfs')
library('rmr2')
library('rhbase')
library('RHive')

## initializaing hdfs
hdfs.init()

## initialize hbase
hb.init()

rmr.options(backend = 'local')

# defining the input data
groups <-to.dfs(keyval(NULL, rbinom(20, n=10, prob=0.5)))

out <-mapreduce(
input=groups,
map=function(k, v) keyval(v,1),
reduce=function(k, v) keyval(k, sum(v))
)
outDF <- as.data.frame(from.dfs(out))
head(outDF, 10)
with(outDF, barplot(val, names.arg=key))


