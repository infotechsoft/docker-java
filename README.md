InfotechSoft Java Images
========================

This repository contains `Dockerfiles` for running and building Java applications on CentOS within docker containers.

## How to Use

### As build and runtime environment

Create a `Dockerfile` within the root of your java project, something like:

    FROM infotecsoft/java:7
    COPY . /usr/local/myapp
    WORKDIR /usr/local/myapp
    RUN javac App.java
    CMD ["java", "App"]

You may then build and run the container as follows:

    docker build -t myapp .
    docker run --name app -d myapp

## As runtime environment

Create a `Dockerfile` within the root of your java application, something like:

    FROM infotechsoft/java:7-jre
    COPY . /usr/local/myapp
    CMD ["java", "-cp ./lib/*:./config", "App"]

You may then build and run the container as follows:

    docker build -t myapp .
    docker run --name app -d myapp

