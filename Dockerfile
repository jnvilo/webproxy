FROM centos:7
MAINTAINER Jason Viloria <jnvilo@gmail.com>
RUN yum -y install epel-release && yum -y install yum-utils && yum -y install nginx certbot python2-certbot-nginx

COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/ssl /etc/nginx/ssl
COPY certs.sh /
COPY start.sh /
COPY nginx/conf.d /etc/nginx/conf.d
EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]
#CMD ["/bin/bash", "/start.sh"]
