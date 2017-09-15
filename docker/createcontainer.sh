#!/bin/sh
name=$1
version=1
docker container prune -f

if [ -z "${name}" ]; then 
   exit -1 ;
fi

mkdir -p  /home/docker/mysql/${name}/data
mkdir -p  /home/docker/mysql/${name}/conf
mkdir -p  /home/docker/mysql/${name}/initsql

cp -n /home/docker/docker/conf/*  /home/docker/mysql/${name}/conf
cp -n /home/docker/docker/initsql/*.sql  /home/docker/mysql/${name}/initsql
cp -rf /home/docker/docker/tomcat  /home/docker/mysql/${name}/

docker run --name mysql${name} -e MYSQL_ROOT_PASSWORD=sunway123# -d -P \
    -v /home/docker/mysql/${name}/data:/var/lib/mysql  \
    -v /home/docker/mysql/${name}/initsql:/docker-entrypoint-initdb.d \
    -v /home/docker/mysql/${name}/conf:/etc/mysql/conf.d   mysql


