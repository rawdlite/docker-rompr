[![](https://images.microbadger.com/badges/image/rawdlite/rompr.svg)](https://microbadger.com/images/rawdlite/rompr "Get your own image badge on microbadger.com")
docker-rompr
=================

Docker Container to run a Rompr (https://fatg3erman.github.io/RompR/) instance.

The Image is a multi-platform build for armv7 (Raspberry Pi, Odroid etc.) and x86 achitecture (amd64)

Credit
------

This work is based on Rompr by fatg3rman and a fork of tutumcloud/lamp

Usage docker
-------------------

	docker run -d -p 80:80 --name rompr rawdlite/rompr


Usage docker-compose
---------------------------------

Create docker-compose.yml


	version: "3"
	services:
	  mopidy:
	    image: rawdlite/mopidy
	    container_name: mopidy
	    devices:
	      - "/dev/snd"
	    ports:
	      - "6600:6600"
	      - "6680:6680"
	    restart: always
	    volumes:
	      - ~/.config/:/root/.config/
	      - /data/music/:/data/music/
	  mysql:
 	    image: rawdlite/rompr_db
	    restart: always
	    container_name: mysql
	    environment:
	      - MYSQL_ALLOW_EMPTY_PASSWORD=true
	      - MYSQL_ROMPR_PASS=R9nM773tYJtcLv
	    ports:
	      - "3306:3306"
	  rompr:
	    image: rawdlite/rompr_apache
	    container_name: rompr
	    restart: always
	    ports:
	      - "80:80"


run

	docker-compose up -d


Using sqlite or a local MySQL Instance
------------------------------------------


Create a docker-compose.yml without the db container


	version: "3"
	services:
	  mopidy:
	    image: rawdlite/mopidy
	    container_name: mopidy
	    devices:
	      - "/dev/snd"
	    ports:
	      - "6600:6600"
	      - "6680:6680"
	    restart: always
	    volumes:
	      - ~/.config/:/root/.config/
	      - /data/music/:/data/music/
	  rompr:
	    image: rawdlite/rompr_apache
	    container_name: rompr
	    restart: always
	    ports:
	      - "80:80"



Configuring ROMPR instance
------------------------------

Open rompr in your Browser:

	http://localhost/

Hello Rompr!

When you see the rompr setup screen 

	Mopidy or mpd Server: mopidy
	Port: 6600

for rompr_db container:

	Server: mysql
	Port: 3360
	Database: romprdb
	Username: rompr
        Password: <MYSQL_ROMPR_PASS>
	
Use Password from from docker-compose.yml.

Select 'Full Database Collection'.
Hit 'OK'

for sqlite:

Select 'Lite Database Collection'

For using MySQL on local host:

find Host IP for docker Network

        ip addr

docker0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
    inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0

        Server: 172.17.0.1

Bind to another port
-----------------------------

In case you already have a webserver running under port 80 on your host you can bind an alternative port like 8080

	docker run -d -p 8080:80 rawdlite/docker-rompr

Open in your Browser:

        http://localhost:8080

Debug
=====

Check php variables:

       http://localhost/phpinfo.php

Entering the container
-------------------------------

Get the container name or id

	docker ps

run a shell in the container

	docker exec -it rompr /bin/bash

