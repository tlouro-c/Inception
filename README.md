# Inception

## Overview
This project is aimed at deploying WordPress using Docker containers. It utilizes three containers: one for MariaDB database, one for WordPress and PHP, and one for Nginx web server.

## Containers:

### MariaDB Container
This container hosts the MariaDB database and ensures data persistence through a volume even if servers go down. It listens on port 3306 for incoming requests from the WordPress container.

### WordPress & PHP Container
This container contains the WordPress installation along with PHP. It has its own volume for data persistence and runs a PHP-FPM daemon listening on port 9000 for PHP requests from the Nginx container.

### Nginx Container
This container serves as the web server and is configured to handle HTTPS requests. It communicates with the WordPress container by sending requests to port 9000 where PHP-FPM is listening. Additionally, it utilizes a shared volume to access WordPress files for serving non-PHP content. Note that Nginx cannot handle PHP requests on its own, which is why it communicates with PHP-FPM.
