# Docker file for CentOS with OpenJDK v8 JDK
FROM centos:centos7

LABEL maintainer="Ray Bradley <https://github.com/rmbrad>"

ARG JAVA8_VERSION
ENV JAVA_VERSION ${JAVA8_VERSION}

RUN if [ -z ${JAVA_VERSION} ]; then export VER=; else export VER=-$JAVA_VERSION; fi && \
	yum -y install java-1.8.0-openjdk-devel$VER && \
	yum -y clean all

ENV JAVA_HOME /usr/lib/jvm/jre
ENV JDK_HOME /usr/lib/jvm/java

CMD ["bash"]
