*This project has been created as part of the 42 curriculum by strieste*

# Description

The Inception project is a system administration project aimed at setting up a suite of systems, all managed by Docker Compose.

This project involves creating a WordPress website using HTTPS, along with all the necessary dependencies, such as

-	Nginx: is a web server that supports SSL/TLS protocols (TLSv1.2/1.3) and forwards PHP requests via FastCGI(Fast Common Gateway Interface).

-	WordPress and PHP-FPM: the application layer, automatically configured at startup with WP_CLI(WordPress Command Line Interface).

-	MariaDB: This is a database that is isolated from the outside world and accessible only via a Docker container on the internal network.

All services run in their own containers created from a custom-built Dockerfile; no pre-built images from Docker Hub are used. All these services communicate via a “bridge” network, and data is stored on your own machine as volumes to ensure persistence.

# Instructions

To get started, you need to install Docker and Docker Compose on your own machine. You can then clone the repository and add your own .env file to the srcs folder. Your .env file should contain:

	-	DOMAINE_NAME

	Database part:
	-	MYSQL_DATABASE
	-	MYSQL_USER
	-	MYSQL_PASSWORD
	-	MYSQL_ROOT_PASSWORD

	WordPress part:
	-	SITE_TITLE
	-	USER_ADMIN
	-	ADMIN_PASSWORD
	-	ADMIN_EMAIL
	-	USER_LOGIN
	-	USER_PASSWORD
	-	USER_EMAIL

You can change the path to the directory where your volume data is stored, this is the “volumes” section of the docker-compose.yml file

To start the service, you can enter the `make` command at the root of this repository. The `make` command locates your Docker Compose file and simply runs the `docker compose up` command, this compiles everything and starts your service. Once all containers are up and running, you can access a container one at a time using the `docker exec -it <service_name>` command, which starts the container and opens a terminal inside it. To access the website in your browser, enter the DOMAIN_NAME variable with port 443, and you’ll be taken to your WordPress site.

If you want to stop this service, you can enter the command ‘make down' this simply stops all containers, but the volumes are not deleted. If you want to clean up everything and delete these volumes, enter the command “make fclean”.

Command part Dockerfile:

- `docker pull <service_name>` : Download image from DockerHub
- `docker build -t <name_app>` : Build image and name it
- `docker images` : Show image list in your machine
- `docker rmi <name>` : Remove image from your machine
- `docker run <name>` : Start your container
- `docker run -d --name <name> <name_app>` : Start your container in detached mode and name it
- `docker ps` : List container running
- `docker ps -a` : List all container
- `docker exec -it <name_app>` : Start your container and launch shell inside
- `docker stop <name_app>` : Stop your container
- `docker rm <name_app>` : Remove your container from your machine
- `docker restart <name_app>` : Restart container
- `docker volume ls` : Liste all container volumes
- `docker volume prune` : Delete all unused volume
- `docker network ls` : List all Docker Networks
- `docker system prune` : Remove stopped containers, unused images, volumes and networks.

Command part Docker Compose:

- `docker-compose up` : build and start your service
- `docker-compose stop` : Stop your service
- `docker-compose ps` : Show all running containers
- `docker-compose logs` : Show container logs

Command part Mariadb:

- `SHOW DATABASES;` : View your container's database
- `USER <name>;` : Enter the table
- `SHOW TABLES;` : Display all items stored in your database
- `exit` : Exit database
- `docker exec -it mariadb mysql -u <name> -p` : Log in your database with password 
- `docker exec -it mariadb mysql -u <name>` : Log in your database without password 

# Resources

https://kinsta.com/blog/docker-commands/

https://docs.docker.com/get-started/docker-concepts/building-images/writing-a-dockerfile/#:~:text=A%20Dockerfile%20is%20a%20text,%2C%20startup%20command%2C%20and%20more.

https://blog.stephane-robert.info/docs/conteneurs/images-conteneurs/ecrire-dockerfile/

https://docs.docker.com/compose/

https://blog.stephane-robert.info/docs/conteneurs/orchestrateurs/docker-compose/

https://docs.docker.com/compose/how-tos/networking/

https://docs.docker.com/reference/compose-file/volumes/

https://fr.wordpress.org/support/article/how-to-install-wordpress/

https://doc.fedora-fr.org/wiki/Installation_et_configuration_de_MariaDB

https://doc.ubuntu-fr.org/mariadb

https://mariadb.com/get-started-with-mariadb/

https://blog.stephane-robert.info/docs/services/web/nginx/

https://doc.ubuntu-fr.org/nginx

## Ai using part:

As part of this project, I am using AI to explain what containers, Docker, and Docker Compose are, how they are used, and how they work, this helps provide a better understanding of all the services and the specific features of certain components.

# Additional

-	Virtual machine vs Docker

The difference between a virtual machine (VM) and Docker is that a VM virtualizes an entire computer; this consumes far more resources, which would make it impossible to create such a large number of VMs on a single computer. Docker, on the other hand, includes only the bare minimum required for the service to run; it uses the host machine’s components and shares them among each container.

-	Secrets vs Environment Variables

The main difference is that if you store your password and other information in your .env file, you can view these values inside your container using the `env` command or via `docker inspect`. However, if you use the Secret folder, this information is not visible inside your container via `env`, which provides greater security.

-	Docker Network vs Host Network

The main difference is that a host network allows all services to use the host machine’s network; this gives you direct access to all services without having to go through the single port exposed by Nginx, as defined in the Docker Compose file. Conversely, a Docker network creates a network that only your services can access and that is not visible from the outside; it is therefore impossible to access the database directly from your own machine, which makes all services more secure.

-	Docker Volumes vs Bind Mounts

The difference between a bind mount and a Docker volume is that a bind mount specifies exactly where data should be stored on the host computer; therefore, the path must be changed if the project is used on a different machine. A Docker volume, on the other hand, lets Docker manage the data storage location, which makes it easier to export services but makes them less flexible.