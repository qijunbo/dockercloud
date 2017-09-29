#!/bin/sh
name=$1

if [ -z "${name}" ]; then
     echo Usage: $0 username
     exit -1 ;
fi
echo "Container created at `date` for ${name} " >>DBCreate.log


#这里的-f参数判断数据库初始脚本是否存在  
if [ ! -f "/opt/docker/everyone/mysql/initsql/init.sql" ]; then  
   exit -2 
fi  

#这里的-f参数判断mysql容器配置文件是否存在  
if [ ! -f "/opt/docker/everyone/mysql/conf/docker.cnf" ]; then  
   exit -2
fi  

# create folder to store mysql data
rm -rf /opt/docker/${name}/mysql/data
mkdir -p  /opt/docker/${name}/mysql/data

# create folder to store tomcat logs
mkdir -p  /opt/docker/${name}/tomcat/logs

# create folder to store tomcat server.xml
mkdir -p  /opt/docker/${name}/tomcat/conf

logger "Work folder created for ${name} at:/opt/docker/${name}"

docker stop mysql${name}
docker container prune -f
echo "docker run --name mysql${name} \
    -v /opt/docker/${name}/mysql/data:/var/lib/mysql  \
    -v /opt/docker/everyone/mysql/initsql:/docker-entrypoint-initdb.d \
    -v /opt/docker/everyone/mysql/conf/docker.cnf:/etc/my.cnf \
    -e MYSQL_ROOT_PASSWORD=sunway123#  \
    -d -P mysql \
    --character-set-server=utf8 --collation-server=utf8_general_ci"

docker ps -a
logger "Mysql container(mysql${name}) started at: `date`"

