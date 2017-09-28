#!/bin/sh
name=$1
if [ -z "${name}" ]; then
   echo "Usage $0 name"
   exit -1 ;
fi
ip=`docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ${name}`
port=`docker inspect --format='{{(index (index .NetworkSettings.Ports "3306/tcp") 0).HostPort}}' ${name}`
echo "jdbc:mysql://${ip}:${port}/dbs_dev?useSSL=false"





