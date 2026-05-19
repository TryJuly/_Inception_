*This project has been created as part of the 42 curriculum by strieste*

This document explain how a developper can use this projet.

# Set up the environment from scratch

## Prerequisites

Before strating, make sure the following tools are installed on the host machine

-	Docker engine
-	Docker compose
-	make
-	git

Project structure:

.
├── Makefile
└── srcs/
    ├── docker-compose.yml
    ├── .env
    └── requirements/
        ├── nginx/       (Dockerfile + conf + TLS certificates)
        ├── wordpress/   (Dockerfile + wp-config + entrypoint)
        └── mariadb/     (Dockerfile + my.cnf + init script)

## Configuration files and secrets

1.	Clone the repository

2.	Add the project domain to /etc/hosts:
	127.0.0.1	login.42.fr

3.	Create the host data directorie:
	mkdir -p /home/login/data/wordpress
	mkdir -p /home/login/data/mariadb

4.	Create the srcs/.env file containing secret:

	DOMAINE_NAME=https://strieste.42.fr
	MYSQL_DATABASE=...
	MYSQL_USER=...
	MYSQL_PASSWORD=...
	MYSQL_ROOT_PASSWORD=...
	SITE_TITLE=...
	USER_ADMIN=...
	ADMIN_PASSWORD=...
	ADMIN_EMAIL=...
	USER_LOGIN=...
	USER_PASSWORD=...
	USER_EMAIL=...

The .env file must be ignored in .gitignore, No secret, password or TLS certificate should be commit to the repository.

## Build and launch with the Makefile and docker compose

The Makefile is a wrapper around docker compose, the main rules call docker compose -f srcs/docker-compose.yml

- make : Build the images and start all services.

- make down : Stop and removes container.

- make stop : Pause container without removing them.

- make start : Restart paused container.

- make clean : Remove container and images.

- make fclean : Full clean container, images, volumes, data directory.

- make re : fclean + make

The first build can take several minutes because each dockerfile is built from a stable imgae of Debian

## Manage container and volumes

Usefull commands during development:

- docker ps -a : List every container

- docker logs -f <container> : Follow container logs

- doker exec -it <container> : Open a shell inside a container

- docker inspect <container> : View configuration and mounts

- docker volume ls : List the volumes used by the service

- docker network ls : Check the private network

- docker system prune : free disk space after many rebuilds

## Where the project data is stored

Persistence is handled through bind-mount volume declared in docker-compose.yml. The data lives on the host machine, the container can be destroyed, rebuilt without losing anything. Stopping the service with make down keep the data, only make fclean will erase it.

The host path:

-	/home/login/data/mariadb : MariaDB data file(/var/lib/mysql).

-	/home/login/data/wordpress : WordPress files and uploads(/var/www/html).