#!/bin/bash

path_to_local_config=$1

# check if env var with config exists
if [ -z "$BITMEDIA_TEST_SETTINGS" ]; then
    echo "Need to set BITMEDIA_TEST_SETTINGS"
    exit 1
fi 

# pull if not exist
if [[ "$(docker images -q matveyco/bitmedia-admin:dev)" == "" ]]; then
  # do something
	docker pull matveyco/bitmedia-admin:dev
fi

# create docker containers
docker run -d mongo
sleep 5

docker run -d -v $path_to_local_config:/var/settings/admin/settings_dev.js matveyco/bitmedia-admin:dev
sleep 15

# start mocha
mocha

# stop docker container

docker stop $(docker ps -a -q)
