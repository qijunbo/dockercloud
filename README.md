Quick setup — if you’ve done this kind of thing before
 Set up in Desktop	or	
 HTTPS  https://github.com/qijunbo/lims.git
 SSH  git@github.com:qijunbo/lims.git

We recommend every repository include a README, LICENSE, and .gitignore.
…or create a new repository on the command line

	echo "# lims" >> README.md
	git init
	git add README.md
	git commit -m "first commit"
	git remote add origin https://github.com/qijunbo/lims.git
	git push -u origin master
…or push an existing repository from the command line

	git remote add origin https://github.com/qijunbo/lims.git
	git push -u origin master
…or import code from another repository
You can initialize this repository with code from a Subversion, Mercurial, or TFS project.


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

https://github.com/docker-library/tomcat/blob/64166c6cb450e6701d7b493d1d296c6c1c972a1e/8.5/jre8/Dockerfile

docker container run --name tomcat -d -p 8080:8080 tomcat

docker exec -it tomcat bash

http://192.168.1.30:8080


创建LIMS镜像
===
Dockerfile
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

http://192.168.1.30:8080


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


