[![](https://images.microbadger.com/badges/image/rawdlite/rompr.svg)](https://microbadger.com/images/rawdlite/rompr "Get your own image badge on microbadger.com")
docker-rompr
=================

Docker Container to run a Rompr (https://fatg3erman.github.io/RompR/) instance.

The Image is a multi-platform build for armv7 (Raspberry Pi, Odroid etc.) and x86 achitecture (amd64)

Credit
------

This work is based on Rompr by fatg3rman and a fork of tutumcloud/lamp

Usage docker
------------
The easiest way to get a rompr instance running is:

	docker run -d -p 80:80 --name rompr rawdlite/rompr


Usage docker-compose
---------------------------------
With docker-compose you you can set up a set of containers and a network that connects them.
For a full installation of mopidy, rompr and a full rompr datatabase (mysql)
create a docker-compose.yml like so:


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
            image: linuxserver/mariadb
            restart: unless-stopped
            container_name: mysql
            environment:
              - PUID=1000
              - PGID=1000
              - MYSQL_ROOT_PASSWORD=b4FUk4mF>3As3aA
              - TZ=Europe/Berlin
              - MYSQL_DATABASE=romprdb
              - MYSQL_USER=rompr
              - MYSQL_PASSWORD=R9nM773tYJtcLv
            volumes:
              - ./db_config:/config
            ports:
              - "3306:3306"
	  rompr:
	    image: rawdlite/rompr
	    container_name: rompr
	    restart: always
	    ports:
	      - "80:80"



You need to update the volume pathes to reflect your system.
then run

	docker-compose up -d


Using sqlite or a local MySQL Instance
------------------------------------------

You can configure Rompr to use the Lite Database Collection (sqlite)
then you need no mysql container.  
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
        Password: <MYSQL_PASSWORD>
	
Use Password from from docker-compose.yml.

Select 'Full Database Collection'.
Hit 'OK'


Local Mysql Instance
--------------------
You might already have mysql Instance running on your host.
To use this you need to find the Host IP for docker Network
run:

        ip addr

Find an entry like:
	
	docker0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
    	inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0

Here the required ip is 172.17.0.1 (like mostly)
In the rompr configuration enter.

        Server: 172.17.0.1

Database and user need to be created in your local DB.

Bind to another port
-----------------------------
If you want to use a mysql container and have a local mysql instance at the same time, you ned to change the ports like so:

      ports:
        - "33060:3306"

the port 33060 then needs to be entered in the rompr setup.

In case you already have a webserver running under port 80 on your host you can bind an alternative port like 8080

	docker run -d -p 8080:80 rawdlite/rompr

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

