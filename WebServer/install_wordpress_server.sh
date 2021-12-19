#!/bin/bash
#
# Script for wordpress server installation
#
# run with root
# Debian 10
# Author : Riyas Rawther

apt-get update; apt-get upgrade -y; apt-get install -y fail2ban ufw;
# SSH, HTTP and HTTPS
ufw allow 22
ufw allow 80
ufw allow 443

# Skip the following 3 lines if you do not plan on using FTP
#ufw allow 21 
#ufw allow 50000:50099/tcp 
#ufw allow out 20/tcp

# And lastly we activate UFW
ufw --force enable

#Add some PPAs to stay current
apt-get install -y software-properties-common
apt-add-repository ppa:ondrej/apache2 -y
apt-add-repository ppa:ondrej/php -y

#Set up MariaDB repositories

#apt-key adv --fetch-keys 'https://mariadb.org/mariadb_release_signing_key.asc'
#add-apt-repository 'deb [arch=amd64,arm64,ppc64el] http://mirror.netinch.com/pub/mariadb/repo/10.4/ubuntu focal main'

#Install base packages
apt-get update; apt-get install -y build-essential curl nano wget lftp unzip bzip2 arj nomarch lzop htop openssl gcc git binutils libmcrypt4 libpcre3-dev make python3 python3-pip supervisor unattended-upgrades whois zsh imagemagick uuid-runtime net-tools

#Set the timezone to UTC
ln -sf /usr/share/zoneinfo/UTC /etc/localtime

sudo iptables -I INPUT -p tcp --dport 80 -j ACCEPT
sudo ufw allow http

# install necessary packages
apt update && apt upgrade
apt install mariadb-server mariadb-client
apt install apache2 apache2-mod-php7.3
#apt install nginx
apt install php7.3 php7.3-mysql php7.3-curl php7.3-xml php7.3-zip php7.3-gd php7.3-mbstring php7.3-pspell php7.3-cgi php7.3-xmlrpc php7.3-imap php7.3-bcmath php7.3-imagick php7.3-fpm


apt install php7.3-apcu
#apt install python3-certbot-nginx
apt install python3-certbot-apache
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
systemctl restart apache2
#systemctl restart nginx

# website configuration
touch /etc/apache2/sites-available/setiugadget
echo "server {" >> /etc/apache2/sites-available/setiugadget
echo "    server_name setiugadget.com www.setiugadget.com;" >> /etc/apache2/sites-available/setiugadget
echo "    root /var/www/html;" >> /etc/apache2/sites-available/setiugadget
echo "    index index.php;" >> /etc/apache2/sites-available/setiugadget
echo "" >> /etc/apache2/sites-available/setiugadget
echo "    location / {" >> /etc/apache2/sites-available/setiugadget
echo "        try_files $uri $uri/ /index.php?$args;" >> /etc/apache2/sites-available/setiugadget
echo "    }" >> /etc/apache2/sites-available/setiugadget
echo "" >> /etc/apache2/sites-available/setiugadget
echo "    location ~ \.php$ {" >> /etc/apache2/sites-available/setiugadget
echo "        include snippets/fastcgi-php.conf;" >> /etc/apache2/sites-available/setiugadget
echo "        fastcgi_pass unix:/run/php/php7.3-fpm.sock;" >> /etc/apache2/sites-available/setiugadget
echo "    }" >> /etc/apache2/sites-available/setiugadget
echo "}" >> /etc/apache2/sites-available/setiugadget

rm /etc/apache2/sites-enabled/default
ln -s /etc/apache2/sites-available/setiugadget /etc/apache2/sites-enabled/setiugadget

# display Wordpress parameters
echo "MySQL database created."
echo "Database:   ${wp_database}"
echo "Username:   ${wp_user}"
echo "Password:   ${wp_password}"

# Enable SSL
certbot --apache2 -d setiugadget.com -d www.setiugadget.com
