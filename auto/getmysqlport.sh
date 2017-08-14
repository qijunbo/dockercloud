#!/bin/sh
name=$1
docker inspect --format='{{(index (index .NetworkSettings.Ports "3306/tcp") 0).HostPort}}' mysql${name}


