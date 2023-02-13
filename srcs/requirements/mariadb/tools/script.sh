#!/bin/bash

#set -x

if [ ! -d /var/lib/mysql/$DB_NAME ]
then

	service mysql start;
	mysql -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
	mysql -e "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD';"
	mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER' IDENTIFIED BY '$DB_USER_PASSWORD';"
	mysql -e "FLUSH PRIVILEGES;"
	mysql -e "SET PASSWORD FOR root@localhost = PASSWORD('$DB_ROOT_PASSWORD');"
	sleep 1
	mysqladmin -u root -p${DB_ROOT_PASSWORD} shutdown
fi
exec mysqld_safe
