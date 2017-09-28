#!/bin/sh
name=$1
if [ -z "${name}" ]; then 
     echo Usage: $0  name
     exit -1 ;
fi
mkdir ${name}
echo mkdir ${name} 
docker cp lims${name}:/usr/local/tomcat/conf/ ${name}
echo "docker cp lims${name}:/usr/local/tomcat/conf/ ${name}"
sleep 2
echo "diff -r ./${name}/conf /opt/tomcat/conf"
