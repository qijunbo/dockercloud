#!/bin/sh
name=$1
if [ -z "${name}" ]; then 
   echo Usage: $0 name
   exit -1 ;
fi
docker container stop ${name}
docker container prune -f
docker container run --name ${name} -d   -P ssh-mysql 
