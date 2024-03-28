FROM debian:bullseye

RUN apt-get update -y \
	&& apt-get install mariadb-server mariadb-client -y \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /var/tmp /tmp

COPY conf/mariadb.conf /etc/mysql/mariadb.conf

COPY tools/mariadb.sh .

EXPOSE 3306

ENTRYPOINT [ "mariadb.sh" ]







