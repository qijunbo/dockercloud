
本方案失败, 请参考 env 目录下的方案.

[env](../env/README.md)
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


