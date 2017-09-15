#!/bin/sh
version=$1
if [ -z "${version}" ]; then 
   echo Usage: ./rebuild.sh 1.3
   exit -1 ;
fi
docker container stop lims
docker container prune -f 
docker image rm sunway/lims:$1	
docker image build -t sunway/lims:$1  .
docker images  
