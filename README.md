
MySQL Docker 容器初始化
==

https://github.com/docker-library/mysql/blob/7a850980c4b0d5fb5553986d280ebfb43230a6bb/8.0/Dockerfile

https://github.com/mysql/mysql-docker
	
	mkdir -p  /var/lib/mysql
	
	docker run --name mysql -e MYSQL_ROOT_PASSWORD=sunway123# -d -p 3306:3306 -v /var/lib/mysql:/var/lib/mysql mysql
	 
	docker container exec -it mysql bash
	
	mysql -u root -p 
	密码： sunway123#
	
Then you can start to use the db.

Tomcat Docker 容器初始化
==
https://github.com/docker-library/tomcat/blob/64166c6cb450e6701d7b493d1d296c6c1c972a1e/8.5/jre8/Dockerfile

docker container run --name tomcat -d -p 8080:8080 tomcat

docker exec -it tomcat bash

http://192.168.1.30:8080


创建LIMS生产环境镜像
===
Dockerfile for Pruduction Environment
----
	#Create a LIMS image based on tomcat8
	FROM tomcat:latest
	COPY  iframework /usr/local/iframework
	COPY  server.xml /usr/local/tomcat/conf/server.xml

生成镜像
---	
	docker image rm sunway/lims:1	
	docker image build -t sunway/lims:1  . 
	
启动LIMS
----
	docker container run --name lims -d -p 8080:8080 sunway/lims:1  
	docker exec -it lims bash

http://192.168.1.30:8080/iframework


rebuild.sh
--
	docker container stop lims
	docker container prune -f
	docker image rm sunway/lims:1
	docker image build -t sunway/lims:1  .

restart.sh
--
	docker container stop lims
	docker container rm lims
	docker container prune -f
	docker container run --name lims -d -p 8080:8080 sunway/lims:1

创建开发专用Tomcat容器
===	
特别说明:
--
	开发版容器使用步骤如下:
	1. 把LIMS复制到：/root/docker/mylims/iframework
	2. 启动定制化的tomcat容器。
		docker container run --name mylims -d -P \
		-v /root/docker/mylims/logs:/usr/local/tomcat/logs \
		-v /root/docker/mylims/iframework:/usr/local/iframework sunway/mylims 	
	3. 到这个目录查看日志： 
		/root/docker/mylims/logs
	4. 查看运行在哪个端口：  
		docker port mylims
	

Dockerfile for Development Environment
----
	# Setup a tomcat 8 as a development environment.
	FROM tomcat:latest
	VOLUME  /usr/local/iframework  /usr/local/tomcat/logs 
	COPY  server.xml /usr/local/tomcat/conf/server.xml

生成镜像
---	
	docker image rm sunway/mylims
	docker image build -t sunway/mylims  . 
	
	
启动LIMS
----
	docker container run --name mylims -d -P \
	-v /root/docker/mylims/logs:/usr/local/tomcat/logs \
	-v /root/docker/mylims/iframework:/usr/local/iframework sunway/mylims 
	
	docker exec -it mylims bash
	http://192.168.1.30:<port>/iframework

	
