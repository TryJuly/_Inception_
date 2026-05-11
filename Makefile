FILE = srcs/docker-compose.yml

all: up

up:
	@docker compose -f ${FILE} up -d --build

down:
	@docker compose -f ${FILE} down

stop:
	@docker compose -f ${FILE} stop

start:
	@docker compose -f ${FILE} start

re: down up

clean: down
	@docker compose -f ${FILE} down -v

fclean: clean
	@rm -rf /home/strieste/data/wordpress
	@rm -rf /home/strieste/data/mariadb
	@docker system prune -f
#	clean all no used in docker system