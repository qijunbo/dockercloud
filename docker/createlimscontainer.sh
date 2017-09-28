#!/bin/sh
name=$1
version=$2

if [ -z "${name}" ]; then
     echo Usage: $0 username
     exit -1 ;
fi

if [ -z "${version}" ]; then
     version=1
fi

echo "You are deploy lims${version}."


#mkdir -p  /home/docker/mysql/${name}/data
#mkdir -p  /home/docker/mysql/${name}/conf
#mkdir -p  /home/docker/mysql/${name}/initsql
#mkdir -p  /home/docker/mysql/${name}/logs

#cp -n /home/docker/docker/conf/*  /home/docker/mysql/${name}/conf
#cp -n /home/docker/docker/initsql/*.sql  /home/docker/mysql/${name}/initsql
#cp -rf /home/docker/docker/tomcat  /home/docker/mysql/${name}/
#logger "Work folder created for ${name} at:/home/docker/mysql/${name}"

echo "docker run --name lims${name} -d \
    --link mysql${name}:mysql${name} \
    -v /home/docker/mysql/${name}/logs:/usr/local/tomcat/logs \
    -v /home/docker/mysql/${name}/tomcat/conf:/usr/local/tomcat/conf  -P  sunway/lims:${version}"

docker run --name lims${name} -d \
    --link mysql${name}:mysql \
    -v /home/docker/mysql/${name}/logs:/usr/local/tomcat/logs \
     -P  sunway/lims:${version}

logger "Lims container (lims${name}) started at `date`"

