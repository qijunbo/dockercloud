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
* 打开防火墙的阻碍
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



