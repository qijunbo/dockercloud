#!/bin/sh
name=$1
version=1

if [ -z "${name}" ]; then 
   exit -1 ;
fi

mkdir -p  /home/docker/mysql/${name}/data
# mkdir -p  /home/docker/mysql/${name}/conf
mkdir -p  /home/docker/mysql/${name}/initsql

# cp -n /home/docker/docker/conf/*  /home/docker/mysql/${name}/conf
cp -n /home/docker/docker/initsql/*.sql  /home/docker/mysql/${name}/initsql
cp -rf /home/docker/docker/tomcat  /home/docker/mysql/${name}/
logger "Work folder created for ${name} at:/home/docker/mysql/${name}"
docker rm -f  mysql${name} 
docker run --name mysql${name} -e MYSQL_ROOT_PASSWORD=sunway123# -d -P \
    -v /home/docker/mysql/${name}/data:/var/lib/mysql  \
    -v /home/docker/mysql/${name}/initsql:/docker-entrypoint-initdb.d \
          mysql --character-set-server=utf8 --collation-server=utf8_general_ci 
logger "Mysql container(mysql${name}) started at: `date`"

