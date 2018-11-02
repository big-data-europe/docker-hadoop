[![Gitter chat](https://badges.gitter.im/gitterHQ/gitter.png)](https://gitter.im/big-data-europe/Lobby)

# Changes

Version 1.1.0 introduces healthchecks for the containers.

# Hadoop Docker

## Supported Hadoop Versions
* 2.7.1 with OpenJDK 7
* 2.7.1 with OpenJDK 8

## Quick Start

To deploy an example HDFS cluster, run:
```
  docker-compose up
```
or
```
  docker-compose up -d
```
for interactive shell

`docker-compose` creates a docker network that can be found by running `docker network list`, e.g. `docker-hadoop_default`.

Run `docker network inspect` on the network (e.g. `docker-hadoop_default`) to find the IP the hadoop interfaces are published on. Access these interfaces with the following URLs:

* Namenode: http://<dockerhadoop_IP_address>:50070/dfshealth.html#tab-overview
* History server: http://<dockerhadoop_IP_address>:8188/applicationhistory
* Datanode: http://<dockerhadoop_IP_address>:50075/
* Nodemanager: http://<dockerhadoop_IP_address>:8042/node
* Resource manager: http://<dockerhadoop_IP_address>:8088/
to connect from host, use localhost on port number.
* Datanode1: http://localhost:50076/
* Datanode2: http://localhost:50077/
* Datanode3: http://localhost:50078/

after `docker ps` to get names of container, run
`docker exec -ti <container name> /bin/bash` to attach to shell of containers

## Configure Environment Variables

The configuration parameters can be specified in the hadoop.env file or as environmental variables for specific services (e.g. namenode, datanode etc.):
```
  CORE_CONF_fs_defaultFS=hdfs://namenode:8020
```

CORE_CONF corresponds to core-site.xml. fs_defaultFS=hdfs://namenode:8020 will be transformed into:
```
  <property><name>fs.defaultFS</name><value>hdfs://namenode:8020</value></property>
```
To define dash inside a configuration parameter, use triple underscore, such as YARN_CONF_yarn_log___aggregation___enable=true (yarn-site.xml):
```
  <property><name>yarn.log-aggregation-enable</name><value>true</value></property>
```

The available configurations are:
* /etc/hadoop/core-site.xml CORE_CONF
* /etc/hadoop/hdfs-site.xml HDFS_CONF
* /etc/hadoop/yarn-site.xml YARN_CONF
* /etc/hadoop/httpfs-site.xml HTTPFS_CONF
* /etc/hadoop/kms-site.xml KMS_CONF

If you need to extend some other configuration file, refer to base/entrypoint.sh bash script.
