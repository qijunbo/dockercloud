FROM centos
RUN yum install -y java
VOLUME /root/webapp /root/webapp/config
COPY customer.jar /root/webapp/
COPY application* /root/webapp/config/
WORKDIR /root/webapp
EXPOSE 80 8080 443 8443
CMD  java -jar *.jar
