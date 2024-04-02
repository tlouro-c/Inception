IS_DOMAIN_SETUP := $(shell grep -q "tlouro-c.42.fr" /etc/hosts | wc -l)
LOCAL_IP_ADDRESS := $(shell hostname -i)

all: wordpress_mount mariadb_mount
	if [ "$(IS_DOMAIN_SETUP)" = 0 ]; then \
	sudo cp /etc/hosts /etc/host_temporary; \
	echo $(LOCAL_IP_ADDRESS) "     tlouro-c.42.fr" | sudo tee -a /etc/hosts >/dev/null; fi
	docker compose --file srcs/docker-compose.yml up --build --detach

wordpress_mount: 
	sudo mkdir -p /home/tlouro-c/data/wordpress

mariadb_mount:
	sudo mkdir -p /home/tlouro-c/data/mariadb

up:
	docker compose --file srcs/docker-compose.yml up --build --detach

shutdown:
	docker compose --file srcs/docker-compose.yml down

fclean:
	if [ -e /etc/host_temporary ]; then \
	sudo cp /etc/host_temporary /etc/hosts && sudo rm /etc/host_temporary; fi
	docker ps -q | xargs -r docker stop
	docker ps -qa | xargs -r docker rm
	docker images -qa | xargs -r docker rmi 
	docker network ls -q | grep "docker-network" | xargs -r docker network rm >/dev/null 2>&1
	docker volume ls -q | xargs -r docker volume rm >/dev/null 2>&1
	sudo rm -rf /home/tlouro-c/data

re: fclean all
