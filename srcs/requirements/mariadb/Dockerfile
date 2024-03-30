FROM debian:bullseye

RUN apt-get update -y \
	&& apt-get install mariadb-server mariadb-client -y \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

COPY tools/mariadb.sh .

RUN mv ./mariadb.sh /bin \
	&& chmod +x /bin/mariadb.sh

EXPOSE 3306

CMD [ "mariadb.sh" ]







