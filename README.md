InfotechSoft Java Images
========================

This repository contains `Dockerfiles` for running and building Java applications on Rocky Linux within docker containers.

## Building


`./build_and_push.sh [java-version]`

Commonly built Java versions based on OpenJDK:
* Java 1.8.0 (latest: 1.8.0.422)
* Java 11 (latest: 11.0.27)
* Java 17 (latest: 17.0.15)
* Java 21 (latest: 21.0.7)

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

2025-05-13 Updated to use rockylinux/rockylinux:9 base image