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

## initialize hdfs
hdfs.init()

hdfs.ls('/')
hdfs.ls("/tmp")

foo1 = tempfile()
foo2 = tempfile()

writeLines("foo1", con = foo1)
writeLines("foo2", con = foo2)

hdfs.put(foo1, "/tmp/foo1.txt")
hdfs.put(foo2, "/tmp/foo2")

hdfs.ls("/tmp")

hdfs.delete("/tmp/foo1.txt")
hdfs.ls("/tmp")

##################################################

## initialize hbase
hb.init()

hb.list.tables()
#hb.delete.table("test") if test existed

hb.new.table('test','x','y','z')

hb.insert("test",list(list("20100101",c("x:a","x:f","y","y:w"), list("James Dewey",TRUE, 187.5,189000))))
hb.insert("test",list(list("20100102",c("x:a"), list("James Agnew"))))
hb.insert("test",list(list("20100103",c("y:a","y:w"), list("Dilbert Ashford",250000))))
hb.insert("test",list(list("20100104",c("x:f"), list("Henry Higs"))))

hb.get("test",list("20100101","20100102"))
hb.get("test",list("20100101","20100102"),c("y")) # columns that start with y
hb.get("test",list("20100101","20100102"),c("y:w"))
hb.get("test",list("20100101","20100102"),c("y:w","z"))


# delete 
hb.delete("test","20100103","y:a")
hb.get("test","20100103")

# clean up
hb.delete.table("test")