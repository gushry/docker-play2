#!/bin/sh

BRANCH=`git rev-parse --abbrev-ref HEAD | sed -e 's/\///' | sed -e 's/feature//'`

echo $BRANCH

./activator docker:clean docker:stage docker:publishLocal          
docker images

docker tag  docker-play2 gushry/docker-play2:$BRANCH
docker images
docker login -e $DOCKER_EMAIL -u $DOCKER_USER -p $DOCKER_PASS
docker push gushry/docker-play2:$BRANCH
