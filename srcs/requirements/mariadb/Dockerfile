FROM debian:buster
 
RUN apt-get update && apt-get install -y mariadb-server
RUN apt-get install mariadb-client -y
RUN apt-get clean -y && \
	rm -rf /var/lib/apt/lists/*
 
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/script.sh /usr/script.sh

RUN chmod -R 755 /etc/mysql/mariadb.conf.d/50-server.cnf

#exposes the port to another docker, not to host
#EXPOSE 3306

ENTRYPOINT ["/bin/bash", "/usr/script.sh"]
