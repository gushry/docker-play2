#!/bin/sh -x

set -ex

PRJ=$1

curl -X POST https://circleci.com/api/v1/project/$PRJ/tree/master?circle-token=$CIRCLETOKEN
