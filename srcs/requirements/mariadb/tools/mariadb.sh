#! /bin/bash

wordpress_db_dir="/var/lib/mysql/$DB"

if [ ! -d "$wordpress_db_dir" ]; then # If the wordpress_db directory doesn't exist, then create the database
	mysql_secure_installation <<EOF

y
$MYSQL_ROOT_PASSWORD
$MYSQL_ROOT_PASSWORD
y
y
y
y
EOF

	mysql -u root -p"$MYSQL_ROOT_PASSWORD" <<EOF
CREATE DATABASE $DB;
CREATE USER '$MYSQL_MANAGER'@'localhost' IDENTIFIED BY '$MYSQL_MANAGER_PASSWORD';
GRANT ALL PRIVILEGES ON "$DB".* TO '$MYSQL_MANAGER'@'localhost';
FLUSH PRIVILEGES;
EXIT;
EOF
fi
