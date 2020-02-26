.PHONY: build

CENTOS_VERSION := 7

.PHONY: build pull all

all: pull build

build:
	docker build -t lnxsystems/webproxy .

pull:
	docker  pull centos:${CENTOS_VERSION}

run:
	docker run  -p 80:80 -p 443:443 -it lnxsystems/webproxy 

kill:
	 docker ps | grep lnxsystems/webproxy | cut -d " " -f 1| xargs docker kill

debug: pull build run

shell:
	docker exec -it $(docker ps | grep lnxsystems/webproxy | cut -d " " -f 1) /bin/bash
