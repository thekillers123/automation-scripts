#!/bin/bash
#
# Script for wordpress upgrading
#
# run with root

wget https://wordpress.org/latest.tar.gz
tar xpf latest.tar.gz
rm -rf /var/www/html/wp-admin /var/www/html/wp-includes
cp -rf wordpress/* /var/www/html/
chown -R www-data:www-data /var/www/html
find /var/www/html -type d -exec chmod 755 {} \;
find /var/www/html -type f -exec chmod 644 {} \;