# webproxy

Dockerfile to build a centos 7 base image. Contains certbot. This image is used as a base image for deploying a frontend nginx with automated certbot https configuration. 


## Use 


Todo: Add usage howto.



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
