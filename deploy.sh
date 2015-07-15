#!/bin/sh

set -ex

BRANCH=`git rev-parse --abbrev-ref HEAD | sed -e 's/\///' | sed -e 's/feature//'`
IMAGE="docker-play2:1.0-SNAPSHOT"
REPOSITORY="gushry/docker-play2"

echo $BRANCH

./activator docker:clean docker:stage docker:publishLocal          
docker images
echo "========================================================"
docker tag $IMAGE $REPOSITORY:$BRANCH
echo "========================================================"
docker images
docker login -e $DOCKER_EMAIL -u $DOCKER_USER -p $DOCKER_PASS
docker push $REPOSITORY:$BRANCH
