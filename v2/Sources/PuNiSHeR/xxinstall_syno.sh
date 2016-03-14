#!/bin/sh
chmod 777 /dev/tty*
apt-get update
apt-get upgrade
apt-get install sudo
apt-get install curl
apt-get install locales
dpkg-reconfigure locales
echo "export LANG=fr_FR.utf8" >> ~/.bashrc
echo "export LC_ALL=fr_FR.utf8" >> ~/.bashrc
dpkg-reconfigure tzdata
echo "cd /home" >> ~/.bashrc
wget --no-check-certificate http://github.com/jeedom/core/raw/master/install/install.sh
chmod 777 install.sh
./install.sh
wget --no-check-certificate https://github.com/sarakha63/Jeedom_Syno/raw/master/Chroot/jeedom.sh
chmod 777 jeedom.sh
./jeedom.sh stop
sed -i -e "s/3306/3336/g" /etc/mysql/my.cnf
sed -i -e "s/3306/3336/g" /usr/share/nginx/www/jeedom/core/config/common.config.php
wget --no-check-certificate https://github.com/sarakha63/Jeedom_Syno/raw/master/Chroot/default
wget --no-check-certificate https://github.com/sarakha63/Jeedom_Syno/raw/master/Chroot/default_ssl
mv default /etc/nginx/sites-available
mv default_ssl /etc/nginx/sites-available
./jeedom.sh start
rm installopen.sh
