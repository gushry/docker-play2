#!/bin/sh -x

set -ex

#BRANCH=`git rev-parse --abbrev-ref HEAD | sed -e 's/\///' | sed -e 's/feature//'`
BRANCH=`echo $CIRCLE_BRANCH | sed -e 's/^feature\///' | sed -e 's/\///'`
IMAGE="local/app:1.0-SNAPSHOT"
REPOSITORY="gushry/docker-play2"

./activator docker:clean docker:stage docker:publishLocal          
docker tag $IMAGE $REPOSITORY:$BRANCH
docker images
docker login -e $DOCKER_EMAIL -u $DOCKER_USER -p $DOCKER_PASS
docker push $REPOSITORY:$BRANCH
