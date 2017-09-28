#!/bin/sh
name=$1
if [ -z "${name}" ]; then
     echo Usage: $0 username
     exit -1 ;
fi
logger "${name} queried status of  contaienr (mysql${name}) at `date`"
docker inspect --format='{{json .State}}' lims${name}

