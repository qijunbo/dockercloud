#!/bin/sh
name=$1
if [ -z "${name}" ]; then
   echo "Usage $0 name"
   exit -1 ;
fi
ip=`/sbin/ip addr show eth0|grep "inet "|grep -v 127.0.0.1|awk '{print $2}'`
port=`docker inspect --format='{{(index (index .NetworkSettings.Ports "8080/tcp") 0).HostPort}}' lims${name}`
echo "curl -X GET http://${ip%/*}:${port}/${name}"
curl -X GET http://${ip%/*}:${port}/${name}





