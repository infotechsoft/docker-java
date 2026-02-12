# Docker file for Rocky with OpenJDK 
FROM rockylinux/rockylinux:10 AS base
RUN dnf -y upgrade && \
 	dnf -y clean all && \
 	rm -rf /var/cache/*

FROM base
LABEL maintainer="Ray Bradley <https://github.com/rmbrad>"
LABEL maintainer="Thomas Taylor <https://github.com/thomasjtaylor>"

ARG MAJOR_VERSION=
ARG JAVA_VERSION=
ARG JAVA_DIST=jdk

ENV JAVA_VERSION=${JAVA_VERSION}
ENV JAVA_DIST=${JAVA_DIST}

ADD ../apache_install.sh /usr/local/bin/apache_install

RUN dnf -y install https://cdn.azul.com/zulu/bin/zulu-repo-1.0.0-2.noarch.rpm && \
  if [ -z ${JAVA_VERSION} ]; then export VER=; else export VER=-${JAVA_VERSION}; fi && \
  dnf -y install zulu"$MAJOR_VERSION"-"$JAVA_DIST$VER" && \
 	dnf -y clean all && \
 	rm -rf /var/cache/*

ENV JAVA_HOME=/usr/lib/jvm/jre
ENV JDK_HOME=/usr/lib/jvm/java

CMD ["bash"]
