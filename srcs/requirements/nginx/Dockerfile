FROM debian:bullseye

RUN apt-get update -y \
	&& apt-get install -y nginx openssl \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /var/tmp /tmp

WORKDIR /etc/nginx

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout cert.key -out cert.crt -subj "/CN=tlouro-c.42.fr"

COPY ./conf/nginx.conf nginx.conf

CMD [ "nginx", "-g", "daemon off;" ]


