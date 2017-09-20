FROM centos
LABEL name="CentOS7-apache-tomcat-8.5.20"
#RUN yum install -y java
COPY apache-tomcat-8.5.20 /opt/tomcat
COPY tomcat.service  /etc/systemd/system/tomcat.service
COPY startall.sh /bin/startall.sh
CMD ["/bin/bash"]
