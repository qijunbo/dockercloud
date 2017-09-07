
MySQL Docker 容器初始化
==


文件清单:
----

<table width="100%">
<tr><th>File Name</th><th>Description</th><th>备注</th> </tr>
<tr><td>mysql/conf/</td><td> MySQL初始化配置 </td><td>&nbsp;</td></tr>
<tr><td>mysql/initsql/dbsdevbk.sql</td><td> LIMS 的数据库初始化脚本.</td><td>&nbsp;</td></tr>
</table>



操作提示:
----

-  create folders tobe binded with container

```
mkdir -p  /home/docker/mysql/user1/data
mkdir -p  /home/docker/mysql/user1/initsql
mkdir -p  /home/docker/mysql/user1/conf
```	
- Running custom init scripts at database creation
 
copy your  **create_db.sql** into folder  **/docker-entrypoint-initdb.d**,  the sql script will be executed on container start.

```
docker run --name mysql -e MYSQL_ROOT_PASSWORD=sunway123# -d -p 3306:3306 \
	-v /home/docker/mysql/user1/data:/var/lib/mysql  \
	-v /home/docker/mysql/user1/initsql:/docker-entrypoint-initdb.d \
	-v /home/docker/mysql/user1/conf:/etc/mysql/conf.d    mysql
 
docker container exec -it mysql bash

mysql -u root -p 
密码： sunway123#

```

- chek environment variables

```
mysqladmin -u root -p variables  | grep  "case"
```


Reference
---

**Note:** 本文以MySql 8.0 为蓝本

https://github.com/docker-library/mysql/blob/7a850980c4b0d5fb5553986d280ebfb43230a6bb/8.0/Dockerfile

https://github.com/mysql/mysql-docker

