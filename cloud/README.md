
LIMS产品容器化手册
=====

文件清单:
----

<table width="100%">
<tr><th>File Name</th><th>Description</th><th>备注</th> </tr>
<tr><td>lims/Dockerfile</td><td>用于创建基于Tomcat的Webapp镜像.</td><td>&nbsp;</td></tr>
</table>

 
操作提示:
----

- 创建工作目录,  把tomcat容器里面的webapps 目录和外面对接, 这样就可以方便的部署任何war包, 进行调试开发了.

```
mkdir -p  /home/docker/cloud/webapps
mkdir -p  /home/docker/cloud/logs

```

- 执行rebuild.sh  创建镜像.

- 执行restart.sh  启动Lims 演示环境.

```
docker container run --name mytomcat -d \
    -v /home/docker/cloud/logs:/usr/local/tomcat/logs \
	-v /home/docker/cloud/webapps:/usr/local/tomcat/webapps \
	-p 8080:8080 sunway/mytomcat:1 

```

- 重启tomcat容器.

有个比较坑爹的特性,  nginx启动, 并且监听了tomcat容器的情况下,  tomcat容器会 restart (重启)失败. 所以在restart 之前, 一定要临时关闭 nginx

```
/bin/systemctl stop  nginx.service
docker container stop mytomcat
docker container rm mytomcat
docker container prune -f
rm -f  /home/docker/cloud/logs/*
docker container run --name mytomcat -d \
  -v /home/docker/cloud/logs:/usr/local/tomcat/logs \
  -v /home/docker/cloud/webapps:/usr/local/tomcat/webapps -p 8080:8080 sunway/mytomcat:1 

/bin/systemctl start nginx.service

```

