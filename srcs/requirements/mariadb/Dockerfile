FROM debian:bullseye

RUN apt-get update -y \
	&& apt-get install mariadb-server -y \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

COPY tools/mariadb.sh .

RUN mv ./mariadb.sh /bin \
	&& chmod +x /bin/mariadb.sh

EXPOSE 3306

ENTRYPOINT [ "mariadb.sh" ]

CMD [ "mysqld_safe" , "--bind-address=0.0.0.0" ]

