FROM debian:buster

RUN apt-get update
RUN apt-get install wget -y
RUN apt-get install -y php7.3 php-fpm php-mysql mariadb-client

RUN mkdir -p /var/www/html
RUN chown -R root:root /var/www/html

#copying the config file for php and a script for wp
COPY conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf
RUN chmod 755 /etc/php/7.3/fpm/pool.d/www.conf

COPY tools/config.sh /etc/wordpress/config.sh
RUN chmod 775 /etc/wordpress/config.sh

#download WP with wget and unzip it in /var/www
RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www
RUN cd /var/www && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz

#download CLI for automatic configuration
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/html

#EXPOSE 9000

ENTRYPOINT ["/bin/bash", "/etc/wordpress/config.sh"]
