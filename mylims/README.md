
LIMS产品部署
==


文件清单:
----

<table width="100%">
<tr><th>File Name</th><th>Description</th><th>备注</th> </tr>
<tr><td>build.sh </td> <td> 重新创建容器镜像 </td> <td> 危险操作</td> </tr>
<tr><td>Dockerfile </td> <td> 创建镜像的脚本 </td> <td> &nbsp;</td> </tr>
<tr><td>iframework </td> <td> Lims产品待部署文件目录 </td> <td> 把lims 产品文件丢到这个目录即可.</td> </tr>

<tr><td>logs </td> <td> tomcat 日志目录  </td> <td> &nbsp;</td> </tr>
<tr><td>restart.sh </td> <td> 重启lims </td> <td> &nbsp;</td> </tr>
<tr><td>server-10.xml </td> <td> server.xml 备份 </td> <td> &nbsp;</td> </tr>
<tr><td>server-mysql.xml </td> <td> server.xml 备份 </td> <td> &nbsp;</td> </tr>
<tr><td>server-oracle.xml </td> <td> server.xml 备份 </td> <td> &nbsp;</td> </tr>
<tr><td>server.xml </td> <td> server.xml 当前版本 </td> <td> &nbsp;</td> </tr>
<tr><td>test.sh </td> <td> 10分钟后, 查看是否启动成功. </td> <td> &nbsp;</td> </tr>
</table>
 
LIMS 产品发布指南
--

- 把LIMS编译好的文件复制到/home/docker/mylims/iframework 文件夹.

- 执行 restart.sh 即可.

- 可以到logs 里面查看日志, 看看是否启动成功. 



数据库初始化指南 
--
- 把数据库初始化脚本复制到指定目录 /home/docker/mysql/user1/initsql   
- /home/docker/mysql/user1/initsql  和容器内部的 /docker-entrypoint-initdb.d 是同一个目录.
- 进入容器内部:
```
docker container exec -it mysql bash 
```
- 切换到目录 /docker-entrypoint-initdb.d  你就找到了刚才copy的数据库初始脚本.
- 运行mysql
```
mysql -u root -p 
密码： sunway123#
```
- 导入数据库脚本
```
source xxxxx.sql <数据库初始化脚本> 
```


Reference
---

**Note:** 本文以MySql 8.0 为蓝本

https://github.com/docker-library/mysql/blob/7a850980c4b0d5fb5553986d280ebfb43230a6bb/8.0/Dockerfile

https://github.com/mysql/mysql-docker

