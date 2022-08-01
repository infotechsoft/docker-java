#!/usr/bin/env bash

if [ $# -ne 1 ]; then
  echo "Usage: build_and_push.sh <java-version>"
  exit 1
fi

JAVA_VERSION=$1
MAJOR_VERSION=$(echo $JAVA_VERSION | cut -d . -f 1)
if [ $MAJOR_VERSION -eq 1 ]; then
  MAJOR_VERSION=1.8.0
fi

REPO_NAME=infotechsoft/java
BASE_IMAGE_NAME=$REPO_NAME:$JAVA_VERSION

echo "Building Java $MAJOR_VERSION JDK $BASE_IMAGE_NAME"

docker build \
  --build-arg MAJOR_VERSION=$MAJOR_VERSION \
  --build-arg JAVA_VERSION=$JAVA_VERSION \
  -t $BASE_IMAGE_NAME .

echo "Building Java $MAJOR_VERSION JRE $BASE_IMAGE_NAME-jre"

docker build \
  --build-arg MAJOR_VERSION=$MAJOR_VERSION \
  --build-arg JAVA_VERSION=$JAVA_VERSION \
  --build-arg JAVA_DIST=headless \
  -t $BASE_IMAGE_NAME-jre .

docker push $BASE_IMAGE_NAME

docker push $BASE_IMAGE_NAME-jre

for TAG in {$MAJOR_VERSION,openjdk-$MAJOR_VERSION}; do
  docker tag $BASE_IMAGE_NAME $REPO_NAME:$TAG
  docker push $REPO_NAME:$TAG
  docker tag $BASE_IMAGE_NAME-jre $REPO_NAME:$TAG-jre
  docker push $REPO_NAME:$TAG-jre
done
