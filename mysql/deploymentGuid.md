
MySQL Docker 容器初始化
==
**Note:** 本文以MySql 8.0 做实验 

https://github.com/docker-library/mysql/blob/7a850980c4b0d5fb5553986d280ebfb43230a6bb/8.0/Dockerfile

https://github.com/mysql/mysql-docker


Directly Use
----

MySql 容器预置了参数, 允许你在启动容器的时候传入数据库root用户的初始密码. 如下: 

````
mkdir -p  /root/data/mysql

docker run --name mysql -e MYSQL_ROOT_PASSWORD=sunway123# -d -p 3306:3306 -v /root/data/mysql:/var/lib/mysql mysql
 
docker container exec -it mysql bash

mysql -u root -p 
密码： sunway123#

````

Then you can start to use the db.


Container customization
----

-  create folders tobe binded with container

```
mkdir -p  /root/mysql/user1/data
mkdir -p  /root/mysql/user1/initsql
mkdir -p  /root/mysql/user1/conf
```	
- Running custom init scripts at database creation
 
copy your  **create_db.sql** into folder  **/docker-entrypoint-initdb.d**,  the sql script will be executed on container start.

```
docker run --name mysql -e MYSQL_ROOT_PASSWORD=sunway123# -d -p 3306:3306 \
	-v /root/mysql/user1/data:/var/lib/mysql  \
	-v /root/mysql/user1/initsql:/docker-entrypoint-initdb.d \
	-v /root/mysql/user1/conf:/etc/mysql/conf.d    mysql
 
docker container exec -it mysql bash

mysql -u root -p 
密码： sunway123#

```

- chek environment variables

```
mysqladmin -u root -p variables  | grep  "case"
```
	
DB Initialization
----------

- Create DB

	mysqladmin -u root -p  --default-character-set=utf8  create dbs_dev
	mysql -u root -p --default-character-set=utf8 -D dbs_dev </var/lib/mysql/dbs_dev.sql
	
- or

```
mysql -u root -p --default-character-set=utf8
CREATE DATABASE IF NOT EXISTS dbs_dev DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
use dbs_dev;
source /var/lib/mysql/dbs_dev.sql
```

Tomcat Docker 容器初始化
===========

https://github.com/docker-library/tomcat/blob/64166c6cb450e6701d7b493d1d296c6c1c972a1e/8.5/jre8/Dockerfile

docker container run --name tomcat -d -p 8080:8080 tomcat

docker exec -it tomcat bash

http://192.168.1.30:8080


创建LIMS生产环境镜像
--------
- 特别说明：

生成环境容器启动即可，里面已经包含LIMS:
	 
1. 启动lims：

		docker container run --name lims -d -p 8080:8080 sunway/lims:1 		 
2. 访问：
<http://192.168.1.30:8080/iframework>

Create Dockerfile for Pruduction Environment
---

```
#Create a LIMS image based on tomcat8
FROM tomcat:latest
COPY  iframework /usr/local/iframework
COPY  server.xml /usr/local/tomcat/conf/server.xml
```

- Build Docker Image

```	
docker image rm sunway/lims:1	
docker image build -t sunway/lims:1  . 
```

- Start Container for LIMS

```
docker container run --name lims -d -p 8080:8080 sunway/lims:1
```

- Look inside the container.

	docker exec -it lims bash
- Done, Click here to access lims system.

http://192.168.1.30:8080/iframework


rebuild.sh

```
docker container stop lims
docker container prune -f
docker image rm sunway/lims:1
docker image build -t sunway/lims:1  .

```

restart.sh

```
docker container stop lims
docker container rm lims
docker container prune -f
docker container run --name lims -d -p 8080:8080 sunway/lims:1

```

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
	

Create Dockerfile for Development Environment
----
	# Setup a tomcat 8 as a development environment.
	FROM tomcat:latest
	VOLUME  /usr/local/iframework  /usr/local/tomcat/logs 
	COPY  server.xml /usr/local/tomcat/conf/server.xml

Build Customized Tomcat Docker Image 
---	
	docker image rm sunway/mylims
	docker image build -t sunway/mylims  . 
	
	
Start customized Tomcat container.
----
	docker container run --name mylims -d -P \
	-v /root/docker/mylims/logs:/usr/local/tomcat/logs \
	-v /root/docker/mylims/iframework:/usr/local/iframework sunway/mylims 
	
	docker exec -it mylims bash
	http://192.168.1.30:<port>/iframework


rebuild.sh
--
	docker container stop mylims
	docker container prune -f
	docker image rm sunway/mylims
	docker image build -t sunway/mylims  .


restart.sh
-- 
	docker container stop mylims
	docker container rm mylims
	docker container prune -f
	docker container run --name mylims -d -P \
			-v /root/docker/mylims/logs:/usr/local/tomcat/logs \
			-v /root/docker/mylims/iframework:/usr/local/iframework sunway/mylims
	docker port mylims

