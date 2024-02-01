#!/bin/bash

hdfs dfs -copyFromLocal -f /opt/hadoop/applications/input.txt /input/
$HADOOP_HOME/bin/hadoop jar $JAR_FILEPATH $CLASS_TO_RUN $PARAMS
