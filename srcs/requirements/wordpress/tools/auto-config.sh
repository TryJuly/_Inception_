#! /bin/bash

until mysqladmin ping -h mariadb -u $MYSQL_USER -p$MYSQL_PASSWORD --silent; do
	sleep 1
done

if [ ! -f /var/www/wordpress/wp-config.php ]; then
	wp config create --allow-root\
	--dbname=$MYSQL_DATABASE \
	--dbuser=$MYSQL_USER \
	--dbpass="$MYSQL_PASSWORD" \
	--dbhost=mariadb:3306 --path='/var/www/wordpress'

	wp core install --allow-root \
	--url=$DOMAINE_NAME \
	--title=$SITE_TITLE \
	--admin_user=$USER_ADMIN \
	--admin_password="$ADMIN_PASSWORD" \
	--admin_email=$ADMIN_EMAIL

	wp user create --allow-root $USER_LOGIN $USER_MAIL --role=author --user_pass="$USER_PASSWORD"

fi
exec "$@"