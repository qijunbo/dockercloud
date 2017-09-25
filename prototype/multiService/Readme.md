Usage:
--

- Start Container

- Check Port
 
ssh admin@<宿主机器> -p <宿主机器端口>  
mysql -h <宿主机器> -u root -pletmein -P 49172  

“sudo docker inspect myserver | grep IPAddress”来查看容器IP地址 
[plain] view plain copy
ssh admin@<容器机器IP>   
mysql -h <容器机器IP> -u root -pletmein   
