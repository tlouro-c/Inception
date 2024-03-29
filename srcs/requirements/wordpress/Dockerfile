FROM debian:bullseye

RUN apt-get update -y \
	&& apt-get install wget \
	php \
	php-mysql php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip -y \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /var/tmp /tmp

WORKDIR /var/www/html/

COPY tools/wordpress.sh .

RUN mkdir ~/bin \
	&& mv ./wordpress.sh ~/bin \
	&& export PATH=$PATH:~/bin \
	&& chmod +x ~/bin/*

EXPOSE 9000 3306

ENTRYPOINT [ "wordpress.sh" ]
