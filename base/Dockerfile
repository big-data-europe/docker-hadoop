FROM debian:10

MAINTAINER Ivan Ermilov <ivan.s.ermilov@gmail.com>
MAINTAINER Giannis Mouchakis <gmouchakis@iit.demokritos.gr>

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      openjdk-11-jdk \
      net-tools \
      curl \
      netcat \
      gnupg \
      libsnappy-dev \
      libssl-dev \
    && rm -rf /var/lib/apt/lists/*
      
RUN curl -O https://dist.apache.org/repos/dist/release/hadoop/common/KEYS

RUN gpg --import KEYS

ENV HADOOP_VERSION=3.3.1
# base URL for downloads: the name of the tar file depends
# on the target platform (amd64/x86_64 vs. arm64/aarch64)
ENV HADOOP_BASE_URL=https://www.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION

RUN set -x \
    && ARCH=$(uname -m) \
    && ARCH=$(if test "$ARCH" = "x86_64"; then echo ""; else echo "-$ARCH"; fi) \
    && HADOOP_URL="$HADOOP_BASE_URL/hadoop-$HADOOP_VERSION$ARCH.tar.gz" \
    && curl -fSL "$HADOOP_URL" -o /tmp/hadoop.tar.gz \
    && curl -fSL "$HADOOP_URL.asc" -o /tmp/hadoop.tar.gz.asc \
    && gpg --verify /tmp/hadoop.tar.gz.asc \
    && tar -xvf /tmp/hadoop.tar.gz -C /opt/ \
    && rm /tmp/hadoop.tar.gz*

RUN ln -s /opt/hadoop-$HADOOP_VERSION/etc/hadoop /etc/hadoop
RUN ln -s /opt/hadoop-$HADOOP_VERSION /opt/hadoop

RUN mkdir /opt/hadoop-$HADOOP_VERSION/logs

RUN mkdir /hadoop-data

ENV JAVA_HOME=/usr/lib/jvm/default-java
# create the symlink "/usr/lib/jvm/default-java" in case
# it is not already there (cf. package "default-jre-headless")
RUN if ! test -d $JAVA_HOME; then \
      ln -sf $(readlink -f $(dirname $(readlink -f $(which java)))/..) $JAVA_HOME; \
    fi

ENV HADOOP_HOME=/opt/hadoop-$HADOOP_VERSION
ENV HADOOP_CONF_DIR=/etc/hadoop
ENV MULTIHOMED_NETWORK=1
ENV USER=root
ENV PATH=$HADOOP_HOME/bin/:$PATH

ADD entrypoint.sh /entrypoint.sh

RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
