
LIMS产品容器化手册
=====

文件清单:
----

<table width="100%">
<tr><th>File Name</th><th>Description</th><th>备注</th> </tr>
<tr><td>lims/Dockerfile</td><td>用于创建基于Tomcat的Webapp镜像.</td><td>&nbsp;</td></tr>
<tr><td>lims/rebuild.sh</td><td>删除旧版本的lims镜像,生成新的.</td><td>危险操作</td></tr>
<tr><td>lims/restart.sh</td><td>重启lims 演示环境.</td><td></td></tr>
<tr><td>lims/server.xml</td><td>lims 默认配置文件, 其中的数据库jndi需要酌情修改.</td><td></td></tr>
</table>

 
操作提示:
----

- 创建工作目录, 由于lims产品目前不是war包或者jar包的形式, 所以首先要以文件夹的形式把部署文件copy在当前工作目录下.

```
mkdir -p  /home/docker/lims

## copy  <iframwork>  ./
## copy  servers.xml  ./

```

- 执行rebuild.sh  创建镜像.

- 执行restart.sh  启动Lims 演示环境.


