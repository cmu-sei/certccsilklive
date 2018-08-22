#!/bin/sh

cd "`dirname $0`"
docker-compose -f docker-compose.build.yaml build "$@"