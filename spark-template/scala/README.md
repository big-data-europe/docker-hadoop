# Spark Scala template

The Spark Scala template image serves as a base image to build your own Scala
application to run on a Spark cluster. See
[big-data-europe/docker-spark README](https://github.com/big-data-europe/docker-spark)
for a description how to setup a Spark cluster.

## Scala Console

`sbt console` will create you a Spark Context for testing your code like the
spark-shell:

```
docker run -it --rm bde2020/spark-scala-template sbt console
```

You can also use directly your Docker image and test your own code that way.

## Package your application using sbt

You can build and launch your Scala application on a Spark cluster by extending
this image with your sources. The template uses
[sbt](http://www.scala-sbt.org) as build tool, so you should take the
`build.sbt` file located in this directory and the `project` directory that
includes the
[sbt-assembly](https://github.com/sbt/sbt-assembly).

When the Docker image is built using this template, you should get a Docker
image that includes a fat JAR containing your application and all its
dependencies.

### Extending the Spark Scala template with your application

#### Steps to extend the Spark Scala template

1. Create a Dockerfile in the root folder of your project (which also contains
   a `build.sbt`)
2. Extend the Spark Scala template Docker image
3. Configure the following environment variables (unless the default value
   satisfies):
  * `SPARK_MASTER_NAME` (default: spark-master)
  * `SPARK_MASTER_PORT` (default: 7077)
  * `SPARK_APPLICATION_MAIN_CLASS` (default: Application)
  * `SPARK_APPLICATION_ARGS` (default: "")
4. Build and run the image:
```
docker build --rm=true -t bde/spark-app .
docker run --name my-spark-app -e ENABLE_INIT_DAEMON=false --link spark-master:spark-master -d bde/spark-app
```

The sources in the project folder will be automatically added to `/usr/src/app`
if you directly extend the Spark Scala template image. Otherwise you will have
to add and package the sources by yourself in your Dockerfile with the
commands:

    COPY . /usr/src/app
    RUN cd /usr/src/app && sbt clean assembly

If you overwrite the template's `CMD` in your Dockerfile, make sure to execute
the `/template.sh` script at the end.

#### Example Dockerfile

```
FROM bde2020/spark-scala-template:3.0.1-hadoop3.2

MAINTAINER Cecile Tonglet <cecile.tonglet@tenforce.com>

ENV SPARK_APPLICATION_MAIN_CLASS eu.bde.my.Application
ENV SPARK_APPLICATION_ARGS "foo bar baz"
```

#### Example application

TODO
