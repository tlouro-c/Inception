#! /bin/bash

if [ ! -f "wp-config.php" ]; then
	wget https://wordpress.org/latest.tar.gz
	tar xfz latest.tar.gz
	rm -f latest.tar.gz
	cp wordpress/wp-config-sample.php wordpress/wp-config.php

	sed -i "s/database_name_here/"$DB"/g" wordpress/wp-config.php
	sed -i "s/username_here/"$MYSQL_MANAGER"/g" wordpress/wp-config.php
	sed -i "s/password_here/"$MYSQL_MANAGER_PASSWORD"/g" wordpress/wp-config.php
	sed -i "s/localhost/mariadb/g" wordpress/wp-config.php
	
	mv wordpress/* .
	rm -rf wordpress

	wp core install --url="$DOMAIN" --title=TomsWebsite \
	--admin_user="$WP_ADMIN" --admin_password="$WP_ADMIN_PASSWORD"
	wp user create "$WP_USER" --user_pass="$WP_USER_PASSWORD"
fi


