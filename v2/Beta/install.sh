#!/bin/sh
#SFY alias stef74
#Version jeedom 2.1.1 en chroot synology
# dans le chroot
#cd /tmp
#wget --no-check-certificate https://raw.githubusercontent.com/PuNiSHeR374/Jeedom/master/v2/Beta/install.sh
#chmod+x install.sh
#sh install.sh
# Le port 8088 doit être non utilisé
#De preférence un chroot tout neuf avec un reboot du nas chroot a deja été installé.
# Avoir installé les drivers usb soit manuellement soit par le spk http://www.jadahl.com/domoticz_beta/packages/UsbSerialDrivers_3.0.9.spk
# Enocean don't work on 32bits
#Lors de l'install de apache repondre N a la question.

#status sous syno de apache2 et demarrage des services
cd /home
wget --no-check-certificate https://raw.githubusercontent.com/PuNiSHeR374/Jeedom/master/v2/Beta/jeedom.sh
chmod +x jeedom.sh

#recup config apache2 pour ne pas avoir de messages d'erreurs
#Faut repondre N lors de la question à l'install de apache2
cd /tmp
mkdir /etc/apache2/
wget --no-check-certificate https://raw.githubusercontent.com/PuNiSHeR374/Jeedom/master/v2/Beta/apache2.conf
mv /tmp/apache2.conf /etc/apache2

chmod 777 /dev/tty*
apt-get update
apt-get -y install locales
dpkg-reconfigure locales
dpkg-reconfigure tzdata
apt-get -y upgrade
apt-get -y install build-essential
apt-get -y install Dialog
apt-get -y install sudo
apt-get -y install curl
apt-get -y install libarchive-dev
apt-get -y install libav-tools
apt-get -y install libjsoncpp-dev
apt-get -y install libpcre3-dev
apt-get -y install libssh2-php
apt-get -y install libtinyxml-dev
apt-get -y install libxml2
apt-get -y install make
apt-get -y install mc
apt-get -y install vim
apt-get -y install miniupnpc
apt-get -y install apache2
apt-get -y install apache2.2-common
apt-get -y install bsd-mailx
apt-get -y install cython
apt-get -y install docutils-common
apt-get -y install javascript-common
apt-get -y install locate
apt-get -y install libarchive-dev
apt-get -y install libav-tools
apt-get -y install libjsoncpp-dev
apt-get -y install libpcre3-dev
apt-get -y install libssh2-php
apt-get -y install libtinyxml-dev
apt-get -y install libxml2
apt-get -y install mercurial-common
apt-get -y install mysql-client-5.5
apt-get -y install ncurses-term
apt-get -y install node
apt-get -y install node-normalize-package-data
apt-get -y install node-request
apt-get -y install python-requests

apt-get -y install nodejs
apt-get -y install ntp
apt-get -y install php5-common libapache2-mod-php5 php5-cli
apt-get -y install php5-curl
apt-get -y install php5-dev
apt-get -y install php5-fpm
apt-get -y install php5-json
apt-get -y install php5-mysql
apt-get -y install php5-ldap
apt-get -y install php5-gd
apt-get -y install php-pear
apt-get -y install python-serial
apt-get -y install systemd
apt-get -y install unzip
apt-get -y install usb-modeswitch
apt-get -y install ffmpeg
apt-get -y install avconv
apt-get -y install libudev1
apt-get -y install ca-certificates
apt-get -y install htop
apt-get -y install zip
	
	
echo "export LANG=fr_FR.utf8" >> ~/.bashrc
echo "export LC_ALL=fr_FR.utf8" >> ~/.bashrc

echo "cd /home" >> ~/.bashrc

# on se place dans le repertoire de travail
cd /tmp

#################################Perso########################################
# on recupere la Version 2.1.1
#wget --no-check-certificate https://github.com/jeedom/core/archive/stable.zip

#Decompression du fichier
#unzip /tmp/stable.zip -d /tmp
#cd /tmp/core-stable
#mv *  /var/www/html
###############################################################################
service apache2 stop

wget https://raw.githubusercontent.com/jeedom/core/stable/install/apache_security -O /etc/apache2/conf-available/security.conf
rm /etc/apache2/conf-enabled/security.conf
ln -s /etc/apache2/conf-available/security.conf /etc/apache2/conf-enabled/

rm /var/www/html/index.html

#config apache2
sed -i 's/max_execution_time = 30/max_execution_time = 600/g' /etc/php5/apache2/php.ini
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 1G/g' /etc/php5/apache2/php.ini
sed -i 's/post_max_size = 8M/post_max_size = 1G/g' /etc/php5/apache2/php.ini
sed -i 's/expose_php = On/expose_php = Off/g' /etc/php5/apache2/php.ini
sed -i 's/pm.max_children = 5/pm.max_children = 20/g' /etc/php5/fpm/pool.d/www.conf


#config des droits	
echo "www-data ALL=(ALL) NOPASSWD: ALL" | (EDITOR="tee -a" visudo)


#config du cron
croncmd="su --shell=/bin/bash - www-data -c '/usr/bin/php /var/www/html/core/php/jeeCron.php' >> /dev/null"
cronjob="* * * * * $croncmd"
( crontab -l | grep -v "$croncmd" ; echo "$cronjob" ) | crontab -

#droits jeedom
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 775 /var/www/html

#d'apres la doc jeedom
mkdir -p /var/www/html
rm -rf /root/core-*
wget https://github.com/jeedom/core/archive/stable.zip -O /tmp/jeedom.zip
unzip -q /tmp/jeedom.zip -d /root/
cp -R /root/core-*/* /var/www/html/
cp -R /root/core-*/.htaccess /var/www/html/

# redemarrage des services
service cron restart
service apache2 start
