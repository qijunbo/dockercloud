#!/bin/sh
name=$1
version=1
if [ -z "${name}" ]; then 
     echo Usage: ./startlimsforuser username
     exit -1 ;
fi
docker container prune -f

mkdir -p  /home/docker/mysql/${name}/logs
docker run --name lims${name} -d \
    -v /home/docker/mysql/${name}/logs:/usr/local/tomcat/logs \
    -v /home/docker/mysql/${name}/tomcat/conf:/usr/local/tomcat/conf  -P  sunway/lims:${version}
logger "Lims container (lims${name}) started at `date`"
/bin/systemctl reload nginx
