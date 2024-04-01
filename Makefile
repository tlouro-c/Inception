all:
	sudo mkdir -p /home/tlouro-c/data/wordpress
	sudo mkdir -p /home/tlouro-c/data/mariadb
	docker compose --file srcs/docker-compose.yml up --build --detach
	
fclean:
	docker stop nginx-container wordpress-container mariadb-container
	docker rm nginx-container wordpress-container mariadb-container
	docker rmi nginx wordpress mariadb
	docker network rm docker-network
	docker volume rm mariadb-volume wordpress-volume
re: fclean all
