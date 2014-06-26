## OpenJDK v1.7 JRE Dockerfile

A **Dockerfile** of OpenJDK 1.7 JRE installed in CentOS for [Docker](https://www.docker.io/). Intended mainly to be used as a base image for Java based services. 

### Installation

You can build an image from within the **Dockerfile** directory using:
	
	docker build -t="rmbrad/openjdk7-jre" .

Alternatively, you may use the image from [Docker Hub](https://hub.docker.com) as follows:

	docker pull rmbrad/openjdk7-jre

### Usage

	docker run -it --rm rmbrad/openjdk7-jre
