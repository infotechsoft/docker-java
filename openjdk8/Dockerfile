# Docker file for CentOS with OpenJDK v7 JDK
FROM centos:centos7

MAINTAINER Ray Bradley "https://github.com/rmbrad"

ENV JAVA_VERSION 1.8.0.60

RUN yum -y install java-1.8.0-openjdk-devel-$JAVA_VERSION && \
	yum -y clean all

ENV JAVA_HOME /usr/lib/jvm/jre
ENV JDK_HOME /usr/lib/jvm/java

CMD ["bash"]
