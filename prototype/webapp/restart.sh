#!/bin/sh
name=$1
if [ -z "${name}" ]; then
   echo "Usage $0 name"
   exit -1 ;
fi
docker container prune -f
docker run --name ${name} -d -P qijunbo/java:8
docker ps -a 



