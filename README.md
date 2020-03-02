# webproxy

Dockerfile to build nginx on centos:7 base image. Contains certbot. This image is used as a base image for deploying a frontend nginx with automated certbot https configuration. 


## How to use the docker image.

The **webproxy** docker image expects to have two docker volume mounts. 

* **frontend_letsencrypt** - This gets mounted to /etc/letsencrypt inside the docker container. This should contain the certbot certificates. 
* **frontend_nginx_etc_conf_d** - This gets mounted to /etc/nginx/conf.d inside the docker continer. This should contain the vhost conf files. 

### Step1: Create the docker-compose.yml as follows: 

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
### Step2: Create the volumes: 

/usr/bin/docker volume create frontend_letsencrypt
/usr/bin/docker volume create frontend_nginx_etc_conf_d


### Step3: Add the virtual host configuration 

In the docker-compose.yml we created a volume and mounted /etc/nginx/conf.d. Create a http virtual host as shown below. There 
is no need to bother about the https configuration. The certbot will configure it automatically. 

```
server {
    server_name www.example.com;
    server_tokens off;
    
    location / {
    }
 }
```

### Step4: 

```
docker-compose up 
```
This will start the image but it will not yet have the certificates. We need to execute certs.sh inside the docker container. 


```
docker exec -it <container_id_or_name> /certs.sh
```

```
docker-compose down; docker-compose up
```



### notes:

certbot --nginx --renew-by-default   --redirect --staging -m jnvilo@gmail.com --agree-tos --eff-email -d harbor.lnxsystems.com 
