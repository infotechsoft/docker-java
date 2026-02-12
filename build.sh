#!/usr/bin/env sh
set -e

PUSH=
if [ "$(printf '%s' "${1}" | tr '[:upper:]' '[:lower:]')" = "push" ]; then
  # PUSH=--push
  echo "Pushing images to Docker Hub"
else
  echo "Building images only"
fi
JAVA_VERSIONS="${JAVA_VERSIONS:-8 11 17 21 25}"
REPO_NAME=infotechsoft/java

for MAJOR_VERSION in $JAVA_VERSIONS; do 
  BASE_IMAGE_NAME=$REPO_NAME:$MAJOR_VERSION

  echo "Building Java $MAJOR_VERSION JDK $BASE_IMAGE_NAME"  
  docker build \
    --build-arg MAJOR_VERSION="$MAJOR_VERSION" \
    --build-arg JAVA_VERSION= \
    --build-arg JAVA_DIST=jdk \
    --pull \
    ${PUSH:+"$PUSH"} \
    --tag "$BASE_IMAGE_NAME" \
    --tag "$BASE_IMAGE_NAME"-jdk \
    --tag "$REPO_NAME":zulu-"$MAJOR_VERSION"-jdk \
    --provenance=true \
    --sbom=true \
    .

  echo "Building Java $MAJOR_VERSION JRE $BASE_IMAGE_NAME-jre"
  docker build \
    --build-arg MAJOR_VERSION="$MAJOR_VERSION" \
    --build-arg JAVA_VERSION= \
    --build-arg JAVA_DIST=jre \
    --pull \
    ${PUSH:+"$PUSH"} \
    --tag "$BASE_IMAGE_NAME"-jre \
    --tag "$REPO_NAME":zulu-"$MAJOR_VERSION"-jre \
    --provenance=true \
    --sbom=true \
    .

  if docker scout >/dev/null 2>&1 ; then
    echo "Generating CVE report for $BASE_IMAGE_NAME"
    docker scout cves --format markdown "$BASE_IMAGE_NAME" > reports/java-"$MAJOR_VERSION"-cves.md
  else
    echo "Docker scout not installed, skipping CVE report..."
  fi
done



