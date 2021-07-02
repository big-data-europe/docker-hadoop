ARG HADOOP_BASE_VERSION=2.0.0-hadoop3.3.1-java11
FROM bde2020/hadoop-base:$HADOOP_BASE_VERSION

MAINTAINER Ivan Ermilov <ivan.s.ermilov@gmail.com>

HEALTHCHECK CMD curl -f http://localhost:8042/ || exit 1

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 8042

CMD ["/run.sh"]
