云端环境搭建笔记
==

Chub服务的部署
--
* 把containerhub 的jar包复制到合适的地方, 并部署成一个服务.
```
mkdir -p  /opt/sunway
cd /etc/init.d
ln -sf /opt/sunway/containerhub-0.1.0.jar  chub
chkconfig chub on
```

* 启动和停止服务
```
service chub start
service chub stop
```

Nginx 的部署
---
阿里云的服务器只对外暴露了80端口,  而且服务器居然是通过代理服务器来访问的. 所以只好用nginx来把服务公开出去了.
* 为防火墙增加http, https服务
```
sudo firewall-cmd --permanent --zone=public --add-service=http 
sudo firewall-cmd --permanent --zone=public --add-service=https
sudo firewall-cmd --reload
```

* 启动和停止nginx
```
systemctl enable  nginx.service
systemctl start  nginx.service
systemctl status nginx.service
systemctl stop nginx.service
systemctl reload nginx.service
```

* 配置代理文件
```
vi /etc/nginx/conf.d/chub.conf
```
保存如下内容
```
server {
        listen       80;
        server_name  118.190.153.23;
        index index.php index.html index.htm;

        location /chub {
                proxy_set_header X-Forwarded-Host $host;
                proxy_set_header Host $http_host;
                proxy_set_header X-Forwarded-Server $host;
                proxy_pass http://172.31.209.221:81/;
                client_max_body_size    10m;
        }
}
```
重启nginx
```
systemctl reload nginx.service
```
生效:
通过这个link访问:  http://118.190.153.23/chub

* 小窍门, 查看IP地址

```
ip addr

ip addr show eth0 | grep inet | awk '{ print $2; }' | sed 's/\/.*$//'

firewall-cmd --zone=public --list-ports

```

Host 配置
--
```
echo `ip addr show eth0 | grep inet | awk '{ print $2; }' | sed 's/\/.*$//'` mysqlserver >>/etc/hosts
```



Tomcat 安装配置
--
- Install the software.

```
wget http://apache.mirrors.ionfish.org/tomcat/tomcat-8/v8.5.9/bin/apache-tomcat-8.5.9.tar.gz
sudo mkdir /opt/tomcat
sudo tar xvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1
cd /opt/tomcat
```
- Config as  a service.
create this file:

```
sudo vi /etc/systemd/system/tomcat.service
```
- Paste in the following script. You may also want to modify the memory allocation settings that are specified in **CATALINA_OPTS:** 

```
# Systemd unit file for tomcat
[Unit]
Description=Apache Tomcat Web Application Container
After=syslog.target network.target

[Service]
Type=forking

Environment=JAVA_HOME=/usr/lib/jvm/jre
Environment=CATALINA_PID=/opt/tomcat/temp/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat
Environment=CATALINA_BASE=/opt/tomcat
Environment='CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC'
Environment='JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/bin/kill -15 $MAINPID

User=root
Group=root
UMask=0007
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target
```
- Now reload Systemd to load the Tomcat unit file:

```
sudo systemctl daemon-reload

```
- Start service, enable the service at linux startup

```
sudo systemctl start tomcat
sudo systemctl status tomcat
sudo systemctl enable tomcat
```

Limx Cloud 的部署
--

把war包copy到/home/docker/env目录下. 
执行 deploycloud.war.sh 