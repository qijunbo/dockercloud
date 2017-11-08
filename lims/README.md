LIMS 产品打包指南
==

- 下载脚本
SVN路径:  http://mdm.sunwayworld.com/svn/iframework/iframework/trunk/lims-cloud/script

你应该能够看到如下的文件结构

```
limscloud
 ├─ script
	├── docker
	├── env
	├── lims
	├── tomcat-redis
	├── msggateway
	├── mysql
	└── redis

```

- 准备tomcat-redis基础镜像

limscloud/script/tomcat-redis  目录下包含了基础镜像的构建脚本, 请查看里面的[README.md](../tomcat-redis/README.md)了解构建过程.

该镜像是作为LIMS产品的父镜像使用的, 换句话说, LIMS产品镜像继承自该镜像, 因此不必让此镜像运行起来. build完毕即可.

- 构建LIMS产品镜像

我们先来读懂 Dockerfile

```
FROM  tomcat-redis 
LABEL name="lims-all"
COPY  product /sunway/product/ 
COPY  server.xml  /usr/local/tomcat/conf/
VOLUME /usr/local/tomcat/logs /usr/local/tomcat/conf/

```

第一句:  该镜像继承自 tomcat-redis 

第二句:  该镜像的标签是 "lims-all", 这句纯粹是做个记号, 没有实际意义.

第三句:  复制当前目录下 product 到镜像里面 /sunway/product/

第四句:  复制server.xml 到镜像里面tomcat的配置文件目录/usr/local/tomcat/conf/

第五句:  开放mount点, 以便于将来用外面的配置文件取代内部配置文件,  让里面的log可以写到外面的目录里.


然后我们要关注tomcat配置文件Servier.xml

```

<Context path="/activiti-explorer" docBase="/sunway/product/activiti/webapp"  crossContext="true">
	<Resource name="jdbc/framework"  auth="Container"
		type="javax.sql.DataSource"
		username="root" password="sunway123#"
		driverClassName="com.mysql.jdbc.Driver"
		url="jdbc:mysql://172.17.0.2:3306/dbs_dev?useSSL=false"
		maxTotal="200" maxIdle="30"
		testWhileIdle="true" maxWaitMillis="600000"/>
</Context>


<Context path="/lims" docBase="/sunway/product/lims-all/webapp" crossContext="true">
	<Resource name="framework"
		  type="javax.sql.DataSource"
		  username="root"
		  password="sunway123#"
		  driverClassName="com.mysql.jdbc.Driver"
		  url="jdbc:mysql://172.17.0.2:3306/dbs_dev?useSSL=false"
		  maxTotal="20"
		  maxIdle="30"
		  maxWaitMillis="600000"/>
</Context>

```

上面的这段配置中,  只有	docBase="/sunway/product/activiti/webapp" 这个路径是 Docker 最关注的, 而其他内容作为LIMS产品的开发者应该关注, 我们这里只讨论Docker 关注的部分.

在Dockerfile 里面有这么一句 "COPY  product /sunway/product/ ",  这条指令执行完了, 我们要保证路径刚好是 docBase 所需要的. docBase="/sunway/product/activiti/webapp" .

所以开发人员要保证文件存放路径和Server.xml里面的docBase一致. 否则容器无法启动.

读懂了上面的内容, 就可以开始做准备工作了,  把项目最新的server.xml 复制到当前目录;    把项目待部署文件复制到当前目录的 product 目录里面.  然后执行rebuild.sh (假定你已经安装好Docker环境了)

```
./rebuild.sh  版本号
```

构建完毕, 执行下面的指令, 就可以看到你刚才创建的镜像.

```
docker images

```

- 启动容器

如果你想查看tomcat日志的话, 你最好创建一个本地路径, 然后用-v 指令把容器内部的日志目录映射到外面来.

```
docker run --name limsXX -d \
     -v  本地路径/logs:/usr/local/tomcat/logs \
     -P  sunway/lims:版本号
	 
```	 

是不是真的跑起来了呢? 用下面的命令查看, 状态如果是 Exit, 那就说明你失败了. 多数情况下, 第一次都会失败, 你要查查 docBase,  数据源, 等诸多问题.  你可以到 本地路径/logs 里面查看tomcat日志. 总之, 只有你在本地跑通了, 上了云才有希望.
数据源就用你熟悉的好了,  如果用mysql容器数据源, 会大大增加你调试的困难程度.

```
docker ls -a

```


至于端口号, 不是tomcat内部的端口8080,  而是用这个指令查询

```

docker port limsXX

```

祝你好运.


