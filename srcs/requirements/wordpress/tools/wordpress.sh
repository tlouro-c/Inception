#!/bin/bash

cd /var/www/html/

if [ ! -f "wp-config.php" ]; then
	wget https://wordpress.org/latest.tar.gz
	tar xfz latest.tar.gz
	rm -f latest.tar.gz

	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp

	cp wordpress/wp-config-sample.php wordpress/wp-config.php

	sed -i "s/database_name_here/"$DB"/g" wordpress/wp-config.php
	sed -i "s/username_here/"$MYSQL_MANAGER"/g" wordpress/wp-config.php
	sed -i "s/password_here/"$MYSQL_MANAGER_PASSWORD"/g" wordpress/wp-config.php
	sed -i "s/localhost/0a2d206973e9/g" wordpress/wp-config.php

	rm wordpress/wp-config-sample.php
	
	mv wordpress/* .
	rm -rf wordpress

	wp core install --allow-root --url=$DOMAIN --title=TomsWebsite \
	--admin_user=$WP_ADMIN \
	--admin_password=$WP_ADMIN_PASSWORD \
	--admin_email=$WP_ADMIN_EMAIL --skip-email
	wp user create --allow-root $WP_USER --user_pass=$WP_USER_PASSWORD
fi


