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


#rmr.options(backend = 'local')
rmr.options(backend = 'hadoop')

data(iris)

## self-defined R KMeans function
mapreduce_kmeans = 
  function(
    input_data, 
    cluster_number, 
    iter_number, 
    combine) {
    ## Sum of square distant function
    dist.fun = 
      function(C, input_data) {
        apply(
          C,
          1, 
          function(x) 
            colSums((t(input_data) - x)^2))}
    
    ## Map job
    kmeans.map = 
      function(.,input_data) {
        nearest = {
          if(is.null(C)) 
            sample(
              1:cluster_number, 
              nrow(input_data), 
              replace = TRUE)
          else {
            D = dist.fun(C, input_data)
            nearest = max.col(-D)}}
        if(!combine)
          keyval(nearest, input_data) 
        else 
          keyval(nearest, cbind(1,input_data))}
    
    ## Reduce job
    kmeans.reduce = {
      if (!(combine) ) 
        function(.,input_data) 
          t(as.matrix(apply(input_data, 2, mean)))
      else 
        function(k, input_data) 
          keyval(
            k, 
            t(as.matrix(apply(input_data, 2, sum))))}
    
    C = NULL
    for(i in 1:iter_number ) {
      C = 
        values(
          from.dfs(
            mapreduce(
              input_data, 
              map = kmeans.map,
              reduce = kmeans.reduce)))
      if(combine)
        C = C[, -1]/C[, 1]
    
      if(nrow(C) < cluster_number) {
        C = 
          rbind(
            C,
            matrix(
              rnorm(
                (cluster_number - 
                   nrow(C)) * nrow(C)), 
              ncol = nrow(C)) %*% C) }}    
    C}

# main program

output= mapreduce_kmeans(
      input_data=to.dfs(iris[,1:4]),
      cluster_number = 3, 
      iter_number = 5,
      combine = FALSE)
  
output