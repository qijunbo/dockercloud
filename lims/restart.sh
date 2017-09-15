#!/bin/sh
version=$1
if [ -z "${version}" ]; then 
   echo Usage: ./restart.sh 1.3
   exit -1 ;
fi
docker container stop lims
docker container rm lims
docker container prune -f
docker container run --name lims -d \
    -v /home/docker/mysql/user1/logs:/usr/local/tomcat/logs \
    -v /home/docker/mysql/user1/tomcat/conf:/usr/local/tomcat/conf \	
	-p 8080:8080 sunway/lims:$1 
