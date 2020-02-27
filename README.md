# webproxy

Dockerfile to build a centos 7 base image. Contains certbot. This image is used as a base image for deploying a frontend nginx with automated certbot https configuration. 

The **webproxy** docker image expects to have two docker volume mounts. 

* **frontend_letsencrypt** - This gets mounted to /etc/letsencrypt inside the docker container. This should contain the certbot certificates. 
* **frontend_nginx_etc_conf_d** - This gets mounted to /etc/nginx/conf.d inside the docker continer. This should contain the vhost conf files. 

A simple docker-compose.yml can be used to launch it as follows.

```
frontend:
  image:  webproxy
  ports:
    - "80:80"
    - "443:443"
  restart: always
  volumes:
    - frontend_letsencrypt:/etc/letsencrypt
    - frontend_nginx_etc_conf_d:/etc/nginx/conf.d                                                       
```






## build

 ```
 docker build -t jnvilo/webproxy .
 ```
 
 ## Run 
 
 ```
 docker run -p 80:80 -it webproxy
 ```
 
 ## debug
 
 ```
 docker exec -it <CONTAINER ID> /bin/bash
 ```


### notes:

certbot --nginx --renew-by-default   --redirect --staging -m jnvilo@gmail.com --agree-tos --eff-email -d harbor.lnxsystems.com 
