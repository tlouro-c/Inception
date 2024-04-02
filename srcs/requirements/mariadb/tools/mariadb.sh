#!/bin/bash

wordpress_db_dir="/var/lib/mysql/$DB"

if [ ! -d "$wordpress_db_dir" ]; then # If the wordpress_db directory doesn't exist, then create the database

service mariadb start

mysql -u root <<_EOF_ # mysql_secure_installation replacement
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$MYSQL_ROOT_PASSWORD');
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
FLUSH PRIVILEGES;
exit
_EOF_

mysql -u root -p"$MYSQL_ROOT_PASSWORD" <<_EOF_
CREATE DATABASE $DB;
CREATE USER '$MYSQL_MANAGER'@'%' IDENTIFIED BY '$MYSQL_MANAGER_PASSWORD';
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON $DB.* TO '$MYSQL_MANAGER'@'%';
FLUSH PRIVILEGES;
exit
_EOF_

sleep 2 # This sleep is key, and for my own understanding, \
		# when mariadb is started, it needs some time to create the socket file
		# so when it's stopped, the socket exists and there's no error.

service mariadb stop

fi

exec "$@"
