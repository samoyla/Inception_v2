#image built from...
FROM debian:buster

#update cash and install ngnix with the status check after
RUN apt-get update && apt-get upgrade -y
RUN apt-get install nginx -y

#install openssl and generating a self certificate
RUN mkdir -p /etc/nginx/ssl
RUN apt-get install openssl -y
RUN openssl req\
	-new\
	-nodes\
	-x509\ 
	-newkey	rsa:2048\ 
	-out /etc/nginx/ssl/inception.crt\ 
	-keyout /etc/nginx/ssl/inception.key\ 
	-subj "/C=FR/ST=IDF/L=Paris/O=42/OU=Shool 42/CN=masamoil.42.fr/UID=masamoil"

RUN mkdir -p /var/www/html
#RUN mkdir -p /var/run/nginx

COPY conf/nginx.conf /etc/nginx/conf.d/nginx.conf

RUN chmod -R 755 /var/www/html 
RUN chown -R www-data:www-data /var/www/html

#open the port 443
#EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;" ]
