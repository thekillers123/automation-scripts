#!/bin/bash
#
# Script for wordpress server installation
#
# run with root
# Debian 10

# install necessary packages
apt update && apt upgrade
apt install mariadb-server mariadb-client
#apt install apache2 apache2-mod-php7.3
apt install nginx
apt install php7.3 php7.3-mysql php7.3-curl php7.3-xml php7.3-zip \
php7.3-gd php7.3-mbstring php7.3-pspell php7.3-cgi php7.3-xmlrpc php7.3-imap php7.3-bcmath php7.3-imagick php7.3-fpm


apt install php-apcu
apt install python-certbot-nginx
#apt install python-certbot-apache
apt install imagemagick
apt install wget

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
rm -rf /var/www/html/*
cp -rf wordpress/* /var/www/html/
chown -R www-data:www-data /var/www/html
find /var/www/html -type d -exec chmod 755 {} \;
find /var/www/html -type f -exec chmod 644 {} \;

a2enmod rewrite

# restart http server
systemctl restart mariadb
#systemctl restart apache2

systemctl start nginx

# website configuration
touch /etc/nginx/sites-available/zpeng_me
echo "server {" >> /etc/nginx/sites-available/zpeng_me
echo "    server_name zpeng.me www.zpeng.me;" >> /etc/nginx/sites-available/zpeng_me
echo "    root /var/www/html;" >> /etc/nginx/sites-available/zpeng_me
echo "    index index.php;" >> /etc/nginx/sites-available/zpeng_me
echo "" >> /etc/nginx/sites-available/zpeng_me
echo "    location / {" >> /etc/nginx/sites-available/zpeng_me
echo "        try_files $uri $uri/ /index.php?$args;" >> /etc/nginx/sites-available/zpeng_me
echo "    }" >> /etc/nginx/sites-available/zpeng_me
echo "" >> /etc/nginx/sites-available/zpeng_me
echo "    location ~ \.php$ {" >> /etc/nginx/sites-available/zpeng_me
echo "        include snippets/fastcgi-php.conf;" >> /etc/nginx/sites-available/zpeng_me
echo "        fastcgi_pass unix:/run/php/php7.3-fpm.sock;" >> /etc/nginx/sites-available/zpeng_me
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
