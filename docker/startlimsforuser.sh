#!/bin/sh
name=$1
docker container prune -f

if [ -z "${name}" ]; then 
   exit -1 ;
fi

mkdir -p  /home/docker/mysql/${name}/logs
docker run --name lims${name} -d \
    -v /home/docker/mysql/${name}/logs:/usr/local/tomcat/logs -P  sunway/lims:1
