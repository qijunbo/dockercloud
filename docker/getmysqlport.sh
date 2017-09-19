#!/bin/sh
name=$1
logger "${name} queried port of  contaienr (mysql${name}) at `date`"
docker inspect --format='{{(index (index .NetworkSettings.Ports "3306/tcp") 0).HostPort}}' mysql${name}


