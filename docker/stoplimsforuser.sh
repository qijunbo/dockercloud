#!/bin/sh
name=$1

#docker container prune -f
if [ -z "${name}" ]; then
   exit -1 ;
fi
/bin/systemctl stop nginx
docker stop  mysql${name} 
docker stop  lims${name} 
logger "Lims container (lims${name}) Restarted at `date`"
/bin/systemctl start nginx
