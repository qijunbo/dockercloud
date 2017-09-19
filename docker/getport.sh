#!/bin/sh
name=$1
logger "${name} queried port of container (lims${name}) at `date`"
docker inspect --format='{{(index (index .NetworkSettings.Ports "8080/tcp") 0).HostPort}}' lims${name}

