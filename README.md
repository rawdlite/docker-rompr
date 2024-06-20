[![](https://images.microbadger.com/badges/image/rawdlite/rompr.svg)](https://microbadger.com/images/rawdlite/rompr "Get your own image badge on microbadger.com")
docker-rompr
=================

Docker Container to run a Rompr (https://fatg3erman.github.io/RompR/) instance.

Credit
------

This work is based on Rompr by fatg3rman and a fork of tutumcloud/lamp

NOTE:
-----

I no longer maintain images on dockerhub as i moved to Lyrion (https://sites.google.com/view/theaudioniche/lms) for its stable Qobuz intergration.
There seems to be an image chrll/rompr available on dockerhub that uses this code.
Alternatively you can build a local image with the build.local script.

    docker build --build-arg ROMPR_VERSION=2.15 -t local/rompr .

You can update the ROMPR_VERSION Argument to its latest version

Usage docker
------------
The easiest way to get a rompr instance running is:

	docker run -d -p 80:80 --name rompr local/rompr

Usage docker-compose
---------------------------------
You cancreate a docker-compose.yml like so:


	version: "3"
	services:
	  rompr:
	    image: local/rompr
	    container_name: rompr
	    restart: always
	    ports:
	      - "80:80"

Then run the following command in the directory of the docker-compose.yml file:

    docker-compose up -d

For a full installation of mopidy, rompr and a full rompr datatabase (mysql) look at the docker-compose.with_mopidfy_and_mysql file

Configuring ROMPR instance
------------------------------

Open rompr in your Browser:

	http://<ip of your rompr host>:80/

Hello Rompr!

When you see the rompr setup screen

	Mopidy or mpd Server: mopidy
	Port: 6600

The entered prefs will survive a restart of the container as long as you dont change the volume definition in docker-compose.yml
In that case you need to remove the existing container and create a new one.

    docker-compose stop rompr
    docker-compose rm rompr
    docker-compose up -d

Bind to another port
-----------------------------
In case you already have a webserver running under port 80 on your host you can bind an alternative port like 8080

	docker run -d -p 8080:80 local/rompr

Open in your Browser:

        http://<ip of your rompr host>:8080

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
