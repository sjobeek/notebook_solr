FROM debian:jessie

MAINTAINER Erik Sjoberg "sjobeek@gmail.com"

# Leveraged from dockerimages/docker-solr

# No frills here - openjdk7 and some small utils
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    openjdk-7-jre-headless \
    unzip \
    wget \
    procps \
    vim \
    screen \
    lsof \
    curl \
    less && \
    rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

ENV SOLR_VERSION 4.10.3
ENV SOLR solr-$SOLR_VERSION

RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get -y install lsof curl procps \
 && mkdir -p /opt \
 && wget -nv --output-document=/opt/$SOLR.tgz http://www.mirrorservice.org/sites/ftp.apache.org/lucene/solr/$SOLR_VERSION/$SOLR.tgz \
 && tar -C /opt --extract --file /opt/$SOLR.tgz \
 && rm /opt/$SOLR.tgz \
 && ln -s /opt/$SOLR /opt/solr

COPY solr /opt/solr-4.10.3/example/solr

EXPOSE 8983

# We will Put Our Image dockerimages/systemd-solr over that you should directly build that if you plan to run this in production
CMD ["/bin/bash", "-c", "/opt/solr/bin/solr -f"]


