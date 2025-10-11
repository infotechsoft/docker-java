# Docker file for Rocky with OpenJDK 
FROM rockylinux/rockylinux:10 AS base
RUN dnf -y upgrade && \
 	dnf -y clean all && \
 	rm -rf /var/cache/*

FROM base
LABEL maintainer="Ray Bradley <https://github.com/rmbrad>"
LABEL maintainer="Thomas Taylor <https://github.com/thomasjtaylor>"

ARG MAJOR_VERSION=
ARG JAVA_DIST=jdk
ENV JAVA_DIST=${JAVA_DIST}

ADD adoptium.repo /etc/yum.repos.d/adoptium.repo
RUN dnf -y install temurin-$MAJOR_VERSION-$JAVA_DIST && \
 	dnf -y clean all && \
 	rm -rf /var/cache/*

ENV JAVA_HOME=/usr/lib/jvm/jre
ENV JDK_HOME=/usr/lib/jvm/java

CMD ["bash"]
