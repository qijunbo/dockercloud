#!/bin/sh
name=$1
docker container prune -f

if [ -z "${name}" ]; then 
   exit -1 ;
fi


docker run --name mysql${name} -e MYSQL_ROOT_PASSWORD=sunway123# -d -P \
    -v /root/mysql/${name}/data:/var/lib/mysql  \
    -v /root/mysql/${name}/initsql:/docker-entrypoint-initdb.d \
    -v /root/mysql/${name}/conf:/etc/mysql/conf.d   mysql

docker run --name mysql -e MYSQL_ROOT_PASSWORD=sunway123# -itd -p 3306:3306 \
    -v /root/mysql/user1/data:/var/lib/mysql  \
	-v /root/mysql/user1/initsql:/docker-entrypoint-initdb.d \
    -v /root/mysql/user1/conf:/etc/mysql/conf.d    mysql  
 

