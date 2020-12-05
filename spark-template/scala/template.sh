#!/bin/bash

SPARK_APPLICATION_JAR_LOCATION=`find /app/target -iname '*-assembly-*.jar' | head -n1`
export SPARK_APPLICATION_JAR_LOCATION

if [ -z "$SPARK_APPLICATION_JAR_LOCATION" ]; then
	echo "Can't find a file *-assembly-*.jar in /app/target"
	exit 1
fi

/submit.sh
