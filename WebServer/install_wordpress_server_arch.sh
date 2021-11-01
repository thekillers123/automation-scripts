#!/bin/bash
#
# Script for wordpress server installation
#
# run with root
# Arch Linux

# install necessary packages
pacman -Syu
pacman -S mariadb
mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
systemctl enable mariadb

pacman -S nginx-mainline

pacman -S php

pacman -S php-gd php-fpm php-imagick php-pspell php-cgi php-apcu

pacman -S certbot certbot-nginx

# configure Mariadb
mysql_secure_installation








# set up Mariadb for Wordpress
echo '<<< Setting Up Wordpress Database >>>'
read -p 'Input Wordpress Database Username: ' wp_user
read -p 'Input Wordpress Database Password: ' wp_password
read -p 'Input Wordpress Database Name: ' wp_database

mysql -uroot <<MYSQL_SCRIPT
CREATE DATABASE ${wp_database};
CREATE USER '${wp_user}'@'localhost' IDENTIFIED BY '${wp_password}';
GRANT ALL PRIVILEGES ON ${wp_database}.* TO '${wp_user}'@'localhost';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

# install Wordpress
wget https://wordpress.org/latest.tar.gz
tar xpf latest.tar.gz
rm -rf /srv/http*
cp -rf wordpress/* /srv/http
chown -R http:http /srv/http
find /srv/http -type d -exec chmod 755 {} \;
find /srv/http -type f -exec chmod 644 {} \;

# a2enmod rewrite

# restart http server
systemctl restart mariadb
#systemctl restart apache2
systemctl restart nginx
systemctl enable php-fpm

# website configuration
touch /etc/nginx/sites-available/zpeng_me
echo "server {" >> /etc/nginx/sites-available/zpeng_me
echo "    server_name zpeng.me www.zpeng.me;" >> /etc/nginx/sites-available/zpeng_me
echo "    root /srv/http;" >> /etc/nginx/sites-available/zpeng_me
echo "    index index.php;" >> /etc/nginx/sites-available/zpeng_me
echo "" >> /etc/nginx/sites-available/zpeng_me
echo "    location / {" >> /etc/nginx/sites-available/zpeng_me
echo "        try_files $uri $uri/ /index.php?$args;" >> /etc/nginx/sites-available/zpeng_me
echo "    }" >> /etc/nginx/sites-available/zpeng_me
echo "" >> /etc/nginx/sites-available/zpeng_me
echo "    location ~ \.php$ {" >> /etc/nginx/sites-available/zpeng_me
echo "        include fastcgi-php.conf;" >> /etc/nginx/sites-available/zpeng_me
echo "        fastcgi_pass unix:/run/php-fpm/php-fpm.sock;" >> /etc/nginx/sites-available/zpeng_me
echo "    }" >> /etc/nginx/sites-available/zpeng_me
echo "}" >> /etc/nginx/sites-available/zpeng_me

rm /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/zpeng_me /etc/nginx/sites-enabled/zpeng_me

# display Wordpress parameters
echo "MySQL database created."
echo "Database:   ${wp_database}"
echo "Username:   ${wp_user}"
echo "Password:   ${wp_password}"

# Enable SSL
# certbot --nginx -d zpeng.me -d www.zpeng.me
