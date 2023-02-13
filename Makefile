all:
	mkdir -p /home/masamoil/data/wordpress
	mkdir -p /home/masamoil/data/mariadb
	docker compose -f ./srcs/docker-compose.yml up -d 
	docker compose -f ./srcs/docker-compose.yml ps
re: fclean all

#stops and removes containers, networks, volumes and images created by up
down:
	docker compose -f ./srcs/docker-compose.yml down

stop_all:
	-docker stop `docker ps -aq`

cclean:
	-docker rm -f `docker ps -aq`

iclean:
	-docker rmi -f `docker images -aq`

vclean:
	-docker volume rm `docker volume ls -q`

fclean: stop_all cclean iclean vclean 
	docker system prune -af --volumes
	sudo rm -rf /home/masamoil/data
