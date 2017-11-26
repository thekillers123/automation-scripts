#!/bin/bash
#
# Script for wordpress server installation
#
# run with root
# Debian 9

apt update && apt upgrade
apt install mariadb-server mariadb-client
apt install apache2 apache2-mod-php7.0
apt install php7.0 php7.0-mysql php7.0-curl php7.0-xml php7.0-mcrypt php7.0-zip \
            php7.0-gd php7.0-mbstring php7.0-pspell php7.0-cgi php7.0-xmlrpc php7.0-imap
apt install php-apcu
apt install python-certbot-apache
#apt install imagemagick

mysql_secure_installation

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

wget https://wordpress.org/latest.tar.gz
tar xpf latest.tar.gz
rm -rf /var/www/html/*
cp -rf wordpress/* /var/www/html/
chown -R www-data:www-data /var/www/html
find /var/www/html -type d -exec chmod 755 {} \;
find /var/www/html -type f -exec chmod 644 {} \;

a2enmod rewrite

systemctl restart mariadb
systemctl restart apache2

touch /etc/apache2/sites-available/zpeng.me.conf
echo "<VirtualHost *:80>" >> /etc/apache2/sites-available/zpeng.me.conf
echo "    ServerName www.zpeng.me" >> /etc/apache2/sites-available/zpeng.me.conf
echo "    ServerAlias zpeng.me" >> /etc/apache2/sites-available/zpeng.me.conf
echo "    DocumentRoot /var/www/html" >> /etc/apache2/sites-available/zpeng.me.conf
echo "RewriteEngine on" >> /etc/apache2/sites-available/zpeng.me.conf
echo "RewriteCond %{SERVER_NAME} =zpeng.me [OR]" >> /etc/apache2/sites-available/zpeng.me.conf
echo "RewriteCond %{SERVER_NAME} =www.zpeng.me" >> /etc/apache2/sites-available/zpeng.me.conf
echo "RewriteRule ^ https://%{SERVER_NAME}%{REQUEST_URI} [END,QSA,R=permanent]" >> /etc/apache2/sites-available/zpeng.me.conf
echo "</VirtualHost>" >> /etc/apache2/sites-available/zpeng.me.conf

ln -s /etc/apache2/sites-available/zpeng.me.conf /etc/apache2/sites-enabled/zpeng.me.conf

echo "MySQL database created."
echo "Database:   ${wp_database}"
echo "Username:   ${wp_user}"
echo "Password:   ${wp_password}"

# Enable SSL
# certbot --apache
