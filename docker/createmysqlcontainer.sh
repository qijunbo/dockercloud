#!/bin/sh
name=$1

if [ -z "${name}" ]; then 
   echo "Usage: $0 name"
   exit -1 ;
fi

mkdir -p  /docker/everyone/initsql
mkdir -p  /docker/everyone/conf

cp -n init.sql /docker/everyone/initsql/
cp -n docker.cnf /docker/everyone/conf/


#这里的-f参数判断数据库初始脚本是否存在  
if [ ! -f "/docker/everyone/initsql/init.sql" ]; then
   echo "/docker/everyone/initsql/init.sql not found."  
   exit -2 
fi  

#这里的-f参数判断mysql容器配置文件是否存在  
if [ ! -f "/docker/everyone/conf/docker.cnf" ]; then  
   echo "/docker/everyone/conf/docker.cnf not found."  
   exit -2
fi  


mkdir -p  /docker/${name}/data
mkdir -p  /docker/${name}/logs

docker stop mysql${name}
docker container prune -f 
docker run --name mysql${name} \
    -v /docker/${name}/data:/var/lib/mysql  \
    -v /docker/everyone/initsql:/docker-entrypoint-initdb.d \
    -v /docker/everyone/conf/docker.cnf:/etc/my.cnf \
    -e MYSQL_ROOT_PASSWORD=sunway123#  \
    -d -P mysql \
    --character-set-server=utf8 --collation-server=utf8_general_ci 

docker ps -a   
 
