FROM centos
RUN yum install -y java
VOLUME /root/webapp
WORKDIR /root/webapp
EXPOSE 80 8080 443 8443
CMD  java -jar *.jar
