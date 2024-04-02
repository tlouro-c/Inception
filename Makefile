IS_DOMAIN_SETUP := $(shell grep -c "tlouro-c.42.fr" /etc/hosts)
LOCAL_IP_ADDRESS := $(shell hostname -i)

all: mount_wordpress mount_mariadb up
	@if [ "$(IS_DOMAIN_SETUP)" = 0 ]; then \
	sudo cp /etc/hosts /tmp/hosts.tmp; \
	echo $(LOCAL_IP_ADDRESS) "     tlouro-c.42.fr" | sudo tee -a /etc/hosts >/dev/null; \
	sudo rm /tmp/hosts.tmp; \
	fi

mount_wordpress: 
	@sudo mkdir -p /home/tlouro-c/data/wordpress

mount_mariadb:
	@sudo mkdir -p /home/tlouro-c/data/mariadb

up:
	@docker compose --file srcs/docker-compose.yml up --build --detach
	@echo "\n\e[0;32mServers are up!\033[0m\n"

shutdown:
	@docker compose --file srcs/docker-compose.yml down
	@echo "\n\e[0;31mServers are down!\033[0m\n"

fclean:
	if [ "$(IS_DOMAIN_SETUP)" -gt 0 ]; then \
	head -n -1 /etc/hosts > /tmp/hosts.tmp \
    && sudo cp /tmp/hosts.tmp /etc/hosts \
    && sudo rm /tmp/hosts.tmp; \
	fi
	@docker ps -q | xargs -r docker stop >/dev/null 2>&1
	@docker ps -qa | xargs -r docker rm >/dev/null 2>&1
	@docker images -qa | xargs -r docker rmi >/dev/null 2>&1
	@docker network ls -q | grep "docker-network" | xargs -r docker network rm >/dev/null 2>&1
	@docker volume ls -q | xargs -r docker volume rm >/dev/null 2>&1
	@sudo rm -rf /home/tlouro-c/data
	@echo "\n\\e[0;31mFull clean complete!\033[0m\n"

re: fclean all
