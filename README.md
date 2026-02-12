InfotechSoft Java Images
========================

This repository contains `Dockerfiles` for running and building Java applications on Rocky Linux within docker containers.

## Building

`./build.sh [push]?`
* `push` - push the image to the registry


Java versions based on [Eclipse Temurin](https://adoptium.net/):
| Version | Image | Reports |
| --- | --- | --- |
| Java 25  | [infotechsoft/java:25](https://hub.docker.com/repository/docker/infotechsoft/java/tags/25) | [CVES](./reports/java-25-cves.md) |
| Java 21  | [infotechsoft/java:21](https://hub.docker.com/repository/docker/infotechsoft/java/tags/21) | [CVES](./reports/java-21-cves.md) |
| Java 17  | [infotechsoft/java:17](https://hub.docker.com/repository/docker/infotechsoft/java/tags/17) | [CVES](./reports/java-17-cves.md) |
| Java 11  | [infotechsoft/java:11](https://hub.docker.com/repository/docker/infotechsoft/java/tags/11) | [CVES](./reports/java-11-cves.md) |
| Java 8   | [infotechsoft/java:8](https://hub.docker.com/repository/docker/infotechsoft/java/tags/8) | [CVES](./reports/java-8-cves.md) |

## How to Use

### As build and runtime environment

Create a `Dockerfile` within the root of your java project, something like:

    FROM infotechsoft/java:21
    COPY . /usr/local/myapp
    WORKDIR /usr/local/myapp
    RUN javac App.java
    CMD ["java", "App"]

You may then build and run the container as follows:

    docker build -t myapp .
    docker run --name app -d myapp

## As runtime environment

Create a `Dockerfile` within the root of your java application, something like:

    FROM infotechsoft/java:21-jre
    COPY . /usr/local/myapp
    WORKDIR /usr/local/myapp
    CMD ["java", "-cp ./lib/*:./config", "App"]

You may then build and run the container as follows:

    docker build -t myapp .
    docker run --name app -d myapp

## Update History
* 2026-02-12 Updated to [Azul Zulu](https://www.azul.com/products/core/) OpenJDK build
* 2025-10-11 Updated to rockylinux/rockylinux:10, Temurin Java
* 2025-05-13 Updated to use rockylinux/rockylinux:9 base image
