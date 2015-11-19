# Docker file for CentOS with OpenJDK v6 JRE
FROM centos:centos7

MAINTAINER Ray Bradley "https://github.com/rmbrad"

ENV JAVA_VERSION 1.6.0.37

RUN yum -y install java-1.6.0-openjdk-$JAVA_VERSION && \
	yum -y clean all

ENV JAVA_HOME /usr/lib/jvm/jre

CMD ["bash"]
