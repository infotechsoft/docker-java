# Docker file for cent-os with OpenJDK v7 JRE
FROM centos

MAINTAINER Ray Bradley "https://github.com/rmbrad"

RUN yum -y update

RUN yum -y install java-1.7.0-openjdk.x86_64 && yum -y clean all

ENV JAVA_HOME /usr/lib/jvm/jre-1.7.0-openjdk.x86_64

CMD ["bash"]
