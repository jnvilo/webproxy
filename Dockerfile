FROM centos:7
MAINTAINER Jason Viloria <jnvilo@gmail.com>
RUN yum -y install epel-release && yum -y install nginx 


EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

