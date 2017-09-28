#!/bin/sh
name=$1
docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql${name}
logger "${name} queried ip of contaienr (mysql${name}) at `date`"
