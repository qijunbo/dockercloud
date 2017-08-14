#!/bin/sh
name=$1
docker container prune -f

if [ -z "${name}" ]; then 
   exit -1 ;
fi

mkdir -p  /root/mysql/${name}/data
mkdir -p  /root/mysql/${name}/conf
mkdir -p  /root/mysql/${name}/initsql

cp -n conf/*  /root/mysql/${name}/conf
cp -n initsql/*.sql  /root/mysql/${name}/initsql

docker run --name mysql${name} -e MYSQL_ROOT_PASSWORD=sunway123# -d -P \
    -v /root/mysql/${name}/data:/var/lib/mysql  \
    -v /root/mysql/${name}/initsql:/docker-entrypoint-initdb.d \
    -v /root/mysql/${name}/conf:/etc/mysql/conf.d   mysql

docker run --name lims${name} -d -P sunway/lims:1


