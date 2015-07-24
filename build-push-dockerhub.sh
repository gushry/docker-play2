#!/bin/bash -x

set -ex

BRANCH=`echo $CIRCLE_BRANCH | sed -e 's/^feature\///' | sed -e 's/\///'`
IMAGE="local/app:1.0-SNAPSHOT"
REPOSITORY="gushry/docker-play2"
DOCKERFILE="target/docker/docker/stage/Dockerfile"

./activator docker:clean docker:stage
if [ ! -f $DOCKERFILE ];then
  echo "Dockerfile generate failed."
  exit 1
fi
cat $DOCKERFILE | sed -e 's/^ENTRYPOINT.*/ENTRYPOINT ["\/opt\/scripts\/newrelic.sh"]/' | sed -e 's/^CMD.*/CMD ["bin\/docker-play2 -J-javaagent:$(pwd)/newrelic.jar"]/' | sed -e 's/^USER.*//' > /tmp/a
mv /tmp/a $DOCKERFILE
cat $DOCKERFILE

cp newrelic.jar target/docker/docker/stage/opt/docker/

cd target/docker/docker/stage/
pwd
docker build -t $IMAGE .
docker images

docker tag $IMAGE $REPOSITORY:$BRANCH
docker images
docker login -e $DOCKER_EMAIL -u $DOCKER_USER -p $DOCKER_PASS
docker push $REPOSITORY:$BRANCH
