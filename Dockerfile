# Docker file for CentOS with OpenJDK 
FROM rockylinux/rockylinux:9

LABEL maintainer="Ray Bradley <https://github.com/rmbrad>"
LABEL maintainer="Thomas Taylor <https://github.com/thomasjtaylor>"

ARG MAJOR_VERSION=
ARG JAVA_VERSION=
ARG JAVA_DIST=devel
ENV JAVA_VERSION ${JAVA_VERSION}
ENV JAVA_DIST ${JAVA_DIST}

ADD ../apache_install.sh /usr/local/bin/apache_install

RUN if [ -z ${JAVA_VERSION} ]; then export VER=; else export VER=-$JAVA_VERSION; fi && \
        dnf -y upgrade && \
	dnf -y install java-$MAJOR_VERSION-openjdk-$JAVA_DIST$VER && \
	dnf -y clean all && \
	rm -rf /var/cache/*

ENV JAVA_HOME /usr/lib/jvm/jre
ENV JDK_HOME /usr/lib/jvm/java

CMD ["bash"]
