FROM centos:centos6  
  
MAINTAINER Fanbin Kong "kongxx@hotmail.com"  
  
RUN rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm  
RUN yum install -y openssh-server sudo mysql-server mysql supervisor  
RUN sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config   
   
RUN useradd admin  
RUN echo "admin:admin" | chpasswd  
RUN echo "admin   ALL=(ALL)       ALL" >> /etc/sudoers  
   
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key  
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key  
RUN mkdir /var/run/sshd  
  
RUN /etc/init.d/mysqld start &&\  
    mysql -e "grant all privileges on *.* to 'root'@'%' identified by 'letmein';"&&\  
    mysql -e "grant all privileges on *.* to 'root'@'localhost' identified by 'letmein';"&&\  
    mysql -u root -pletmein -e "show databases;"  
  
RUN mkdir -p /var/log/supervisor  
COPY supervisord.conf /etc/supervisord.conf  
  
EXPOSE 22 3306  
CMD ["/usr/bin/supervisord"]  