# Docker file for CentOS with OpenJDK v8 JDK
FROM centos:centos7

LABEL maintainer="Ray Bradley <https://github.com/rmbrad>"

ARG JAVA_VERSION=
ARG JAVA_DIST=devel
ENV JAVA_VERSION ${JAVA_VERSION}
ENV JAVA_DIST ${JAVA_DIST}

RUN if [ -z ${JAVA_VERSION} ]; then export VER=; else export VER=-$JAVA_VERSION; fi && \
	yum -y install java-11-openjdk-$JAVA_DIST$VER && \
	yum -y clean all

ENV JAVA_HOME /usr/lib/jvm/jre
ENV JDK_HOME /usr/lib/jvm/java

CMD ["bash"]
