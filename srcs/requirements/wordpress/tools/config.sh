#!/bin/bash

RETURN=1
while [ $RETURN -ne 0 ]; do
	echo "---------- wordpress is waiting for MariaDB -----------"
	sleep 10
	mysqladmin -u ${DB_USER} -p${DB_USER_PASSWORD} -h mariadb ping # > /dev/null 2>&1
	RETURN=$?
done

#option, which causes the script to print out each command it runs and its arguments, before running the command.
#set -x

	wp core download --allow-root --path="/var/www/html"

	wp core config	--dbhost=$DB_HOST \
		--dbname=$DB_NAME \
		--dbuser=$DB_USER \
		--dbpass=$DB_USER_PASSWORD \
		--allow-root

	wp core install --title=$WP_TITLE \
		--admin_user=$WP_ADMIN_USER \
		--admin_password=$WP_ADMIN_PASSWORD \
		--admin_email=$WP_ADMIN_EMAIL \
		--url=$WP_URL \
		--allow-root

	wp user create $WP_USER $WP_USER_EMAIL --role=contributor --user_pass=$WP_USER_PASSWORD --allow-root

	wp theme install twentytwentytwo --allow-root --force
	wp theme activate twentytwentytwo --allow-root 

mkdir -p /run/php 755 root root

# run php-fpm7.3 listening for CGI request/ as a FastCGI process
exec /usr/sbin/php-fpm7.3 -F
