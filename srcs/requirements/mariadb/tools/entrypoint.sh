#!/bin/bash

#	Start service
service mariadb start

#	Wait DB is ready for process command
until mysqladmin ping > /dev/null 2>&1; do
	sleep 1
done

#	Configure DB and User
mysql -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
mysql -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
mysql -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
mysql -e "FLUSH PRIVILEGES;"

#	Stop service
mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown --silent

#	Start service
exec "$@"