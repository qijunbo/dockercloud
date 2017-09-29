#!/bin/sh
name=$1

if [ -z "${name}" ]; then 
   echo "Usage: $0 name"
   exit -1 ;
fi

mkdir -p  /opt/mysql/${name}/data
mkdir -p  /opt/mysql/everyone/initsql
mkdir -p  /opt/mysql/everyone/conf

cp -f init.sql /opt/mysql/everyone/initsql/
cp -f docker.cnf /opt/mysql/everyone/conf/

docker stop mysql${name}
docker container prune -f 
docker run --name mysql${name} \
    -v /opt/mysql/${name}/data:/var/lib/mysql  \
    -v /opt/mysql/everyone/initsql:/docker-entrypoint-initdb.d \
    -v /opt/mysql/everyone/conf/docker.cnf:/etc/my.cnf \
    -e MYSQL_ROOT_PASSWORD=sunway123#  \
    -d -P mysql \
    --character-set-server=utf8 --collation-server=utf8_general_ci 

docker ps -a   
#docker attach  mysql${name} 
