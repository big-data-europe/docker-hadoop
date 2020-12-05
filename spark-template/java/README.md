# Spark Java template

The Spark Java template image serves as a base image to build your own Java application to run on a Spark cluster. See [big-data-europe/docker-spark README](https://github.com/big-data-europe/docker-spark) for a description how to setup a Spark cluster.

### Package your application using Maven
You can build and launch your Java application on a Spark cluster by extending this image with your sources. The template uses [Maven](https://maven.apache.org/) as build tool, so make sure you have a `pom.xml` file for your application specifying all the dependencies.

The Maven `package` command must create an assembly JAR (or 'uber' JAR) containing your code and its dependencies. Spark and Hadoop dependencies should be listes as `provided`. The [Maven shade plugin](http://maven.apache.org/plugins/maven-shade-plugin/) provides a plugin to build such assembly JARs.

### Extending the Spark Java template with your application

#### Steps to extend the Spark Java template
1. Create a Dockerfile in the root folder of your project (which also contains a `pom.xml`)
2. Extend the Spark Java template Docker image
3. Configure the following environment variables (unless the default value satisfies):
  * `SPARK_MASTER_NAME` (default: spark-master)
  * `SPARK_MASTER_PORT` (default: 7077)
  * `SPARK_APPLICATION_JAR_NAME` (default: application-1.0)
  * `SPARK_APPLICATION_MAIN_CLASS` (default: my.main.Application)
  * `SPARK_APPLICATION_ARGS` (default: "")
4. Build and run the image
```
docker build --rm=true -t bde/spark-app .
docker run --name my-spark-app -e ENABLE_INIT_DAEMON=false --link spark-master:spark-master -d bde/spark-app
```

The sources in the project folder will be automatically added to `/usr/src/app` if you directly extend the Spark Java template image. Otherwise you will have to add and package the sources by yourself in your Dockerfile with the commands:

    COPY . /usr/src/app
    RUN cd /usr/src/app \
        && mvn clean package

If you overwrite the template's `CMD` in your Dockerfile, make sure to execute the `/template.sh` script at the end.

#### Example Dockerfile
```
FROM bde2020/spark-java-template:3.0.1-hadoop3.2

MAINTAINER Erika Pauwels <erika.pauwels@tenforce.com>
MAINTAINER Gezim Sejdiu <g.sejdiu@gmail.com>

ENV SPARK_APPLICATION_JAR_NAME my-app-1.0-SNAPSHOT-with-dependencies
ENV SPARK_APPLICATION_MAIN_CLASS eu.bde.my.Application
ENV SPARK_APPLICATION_ARGS "foo bar baz"
```

#### Example application
See [big-data-europe/demo-spark-sensor-data](https://github.com/big-data-europe/demo-spark-sensor-data).
