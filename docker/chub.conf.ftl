server {
        listen       80;
        server_name  118.190.153.23;
        index index.php index.html index.htm;

	access_log  /etc/nginx/conf.d/log.log main;

<#list values as nginx>
        location /${nginx.productId} {
                proxy_set_header X-Forwarded-Host $host;
                proxy_set_header Host $http_host;
                proxy_set_header X-Forwarded-Server $host;
                proxy_pass http://118.190.153.23/lims/;
                #proxy_pass http://172.31.209.221:${nginx.port}/${nginx.contextPath} ;
                client_max_body_size    10m;
        }
</#list>        

        location /chub {
                proxy_set_header X-Forwarded-Host $host;
                proxy_set_header Host $http_host;
                proxy_set_header X-Forwarded-Server $host;
                proxy_pass http://172.31.209.221:81;
                client_max_body_size    10m;
        }

        location /cloud {
                proxy_set_header X-Forwarded-Host $host;
                proxy_set_header Host $http_host;
                proxy_set_header X-Forwarded-Server $host;
                proxy_pass http://172.31.209.221:8080/cloud;
                client_max_body_size    10m;
        }

        location /lims {
                proxy_set_header X-Forwarded-Host $host;
                proxy_set_header Host $http_host;
                proxy_set_header X-Forwarded-Server $host;
                proxy_pass http://172.31.209.221:8080/lims;
                client_max_body_size    10m;
        }


        location /activiti-explorer {
                proxy_set_header X-Forwarded-Host $host;
                proxy_set_header Host $http_host;
                proxy_set_header X-Forwarded-Server $host;
                proxy_pass http://172.31.209.221:8080/activiti-explorer;
                client_max_body_size    10m;
        }

}
