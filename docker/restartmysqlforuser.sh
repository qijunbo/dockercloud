#!/bin/sh
name=$1
#docker container prune -f
if [ -z "${name}" ]; then
    echo "Usage: %0 name"
    exit -1 ;
fi
/bin/systemctl stop nginx
docker restart lims${name}
logger "Lims container (lims${name}) Restarted at `date`"
/bin/systemctl start nginx
#echo "Lims container (lims${name}) Restarted at `date`" >> container.log
