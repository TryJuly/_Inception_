*This project has been created as part of the 42 curriculum by strieste*

This documents explain how to use the projects for a user.

# Service Provided by the stack

The projet runs a small web infrastructure inside docker container.

.	NGINX: A web server that handles secure HTTPS (TLS v1.2/1.3) connection, Onmy entry point exposed outside.

.	WordPress: The website used to publish content and manage users.

.	MariaDB: The database that stores all WordPress data.

The 3 container communicate through a private Docker Network.

# Start and stop the project

Everything is controlled by using Makefile:

- make : Build the images and start all services.

- make down : Stop and removes container.

- make stop : Pause container without removing them.

- make start : Restart paused container.

- make clean : Remove container and images.

- make fclean : Full clean container, images, volumes, data directory.

- make re : Rebuilds and start everything.

# Access the website and the administration panel

Once the service running, open a web browser and go to : 

.	Website: https://login.42.fr
.	Admin : https;//login.42.fr/wp-admin

A self-signed certificate warning will appear(it's normal for this project). Log in to admin with the administrator credentials defined int the .env file.

# Locate and manage credentials

All sensitive information (Admin user, password ...) is stored in a single file:

-	srcs/.env

This file is not included int the Git repository for security. To change any value Open srcs/.env wiith a text editor. Edit value and Run make re to apply the new value.

Password must not contain "admin" or "administrator" word.

# Check That the service are running

To verifiy the service statue:

-	docker ps

You should see three container Nginx, WordPress and Mariadb each with the status Up.

To inspect service:

-	docker log <container> : view container logs
-	curl -k https://login.42.fr : confirm Nginx is Up
