#!/bin/sh
user=$1
version=$2
if [ -z "${user}" ]; then
   echo Usage: $0 user 2
   exit -1 ;
fi

if [ -z "${version}" ]; then 
   echo Usage: $0 user 2
   exit -1 ;
fi
systemctl stop nginx
docker container stop lims${version}
docker container rm lims${version}
rm -rf /home/docker/mysql/${user}/logs/*
mkdir -p /home/docker/mysql/${user}/logs/
docker run --name lims${version} -d \
    --link mysql${name}:mysql${name} \
    -v /home/docker/mysql/${name}/logs:/usr/local/tomcat/logs \
    -v /home/docker/mysql/${name}/tomcat/conf:/usr/local/tomcat/conf  -p:8081  sunway/lims:${version}
echo "docker run --name lims${version} -d \
    --link mysql${name}:mysql${name} \
    -v /home/docker/mysql/${name}/logs:/usr/local/tomcat/logs \
    -v /home/docker/mysql/${name}/tomcat/conf:/usr/local/tomcat/conf  -p:8081  sunway/lims:${version}"

systemctl start nginx
docker ps -a 
read version 
echo "curl -X GET http://172.31.209.221:8081/lims"
echo 
systemctl status tomcat
more  /home/docker/mysql/${user}/logs/catalina.2017*log
echo "curl -X GET http://172.31.209.221:8081/lims"


