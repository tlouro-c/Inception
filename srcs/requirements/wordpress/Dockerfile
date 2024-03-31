FROM debian:bullseye

WORKDIR /var/www/html/

RUN apt-get update -y \
	&& apt-get install wget curl inetutils-ping \
	php \
	php-mysql php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip php-fpm php-cgi php-cli -y \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

COPY tools/wordpress.sh .

RUN mv ./wordpress.sh /bin \
	&& chmod +x /bin/wordpress.sh

RUN export PATH="$PATH:/usr/sbin" \ 
	&& mkdir -p /run/php 

# export PATH="$PATH:/usr/sbin": add directory to PATH where the php-fpm executable is
# mkdir -p /run/php: php-fpm needed a running directory for the socket file (wasn't being created by default)

EXPOSE 9000

ENTRYPOINT [ "wordpress.sh" ]
