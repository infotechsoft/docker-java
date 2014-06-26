## OpenJDK v1.7 JRE Dockerfile

A **Dockerfile** of OpenJDKs 1.7 [Java](https://www.java.com/) installed in CentOS for [Docker](https://www.docker.io/).

### Installation

You can build an image from within the **Dockerfile** directory using:
	
	docker build -t="rmbrad/openjdk7-jre" .

### Usage

	docker run -it --rm rmbrad/openjdk7-jre
