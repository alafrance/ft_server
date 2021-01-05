#!/bin/bash


#SERVICE LAUNCH
#SSL CERTIFICATE
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt
#sudo openssl dhparam -out /etc/nginx/dhparam.pem 2048
sudo mv self-signed.conf /etc/nginx/snippets/
sudo mv ssl-params.conf /etc/nginx/snippets/
sudo mv default /etc/nginx/sites-available/

#MYSQL
service mysql start
sudo mysql_secure_installation
#mysql < mysql.sql

#SERVICE LAUNCH
service nginx restart
service mysql restart
service php7.3-fpm restart


#PUT WORDPRESS
sudo mv wordpress/* /var/www/html/
rmdir wordpress

#DISPLAY LOGS
tail -f /var/log/nginx/access.log /var/log/nginx/error.log
