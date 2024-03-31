FROM debian:bullseye

RUN apt-get update -y \
	&& apt-get install wget curl inetutils-ping \
	php \
	php-mysql php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip -y \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /var/tmp /tmp

WORKDIR /var/www/html/

COPY tools/wordpress.sh .

RUN mv ./wordpress.sh /bin \
	&& chmod +x /bin/wordpress.sh

EXPOSE 9000

ENTRYPOINT [ "wordpress.sh" ]
