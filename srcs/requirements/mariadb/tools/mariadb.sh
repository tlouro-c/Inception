#! /bin/bash

wordpress_db_dir="/var/lib/mysql/wordpress_db"

if [ ! -d wordpress_db_dir ] then # If the wordpress_db directory doesn't exist, then create the database
	mysql_secure_installation


CREATE DATABASE wordpress_db;

