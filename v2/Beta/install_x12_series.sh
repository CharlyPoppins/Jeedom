#!/bin/sh
#
# Installateur Synology x12 Series
#
#!/bin/sh
# SFY alias stef74
# Version jeedom 2.1.1 en chroot synology
# dans le chroot
# cd /tmp
# wget --no-check-certificate https://raw.githubusercontent.com/PuNiSHeR374/Jeedom/master/v2/Beta/install_mini.sh
# chmod+x install_mini.sh
# sh install_mini.sh
# Le port 8088 doit être non utilisé
# De preférence un chroot tout neuf avec un reboot du nas chroot a deja été installé.
# Avoir installé les drivers usb soit manuellement soit par le spk http://www.jadahl.com/domoticz_beta/packages/UsbSerialDrivers_3.0.9.spk
# Enocean don't work on 32bits
# Lors de l'install de apache repondre N a la question.

#status sous syno de apache2 et demarrage des services
#cd /home
#wget --no-check-certificate https://raw.githubusercontent.com/PuNiSHeR374/Jeedom/master/v2/Beta/jeedom.sh
#chmod +x jeedom.sh

#recup config apache2 pour ne pas avoir de messages d'erreurs
#Faut repondre N lors de la question à l'install de apache2
cd /tmp
mkdir /etc/apache2/
wget --no-check-certificate https://raw.githubusercontent.com/PuNiSHeR374/Jeedom/master/v2/Beta/apache2.conf
mv /tmp/apache2_x12.conf /etc/apache2/apache2.conf

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
apt-get -y install make
apt-get -y install mc
apt-get -y install vim
apt-get -y install apache2
apt-get -y install apache2.2-common

echo "export LANG=fr_FR.utf8" >> ~/.bashrc
echo "export LC_ALL=fr_FR.utf8" >> ~/.bashrc

echo "cd /home" >> ~/.bashrc

# on se place dans le repertoire de travail
cd /tmp

#################################Perso########################################
# on recupere la Version 2.1.1
###############################################################################
service apache2 stop

#wget https://raw.githubusercontent.com/jeedom/core/stable/install/apache_security -O /etc/apache2/conf-available/security.conf
#rm /etc/apache2/conf-enabled/security.conf
#ln -s /etc/apache2/conf-available/security.conf /etc/apache2/conf-enabled/

#rm /var/www/html/index.html

#config apache2
sed -i 's/max_execution_time = 30/max_execution_time = 600/g' /etc/php5/apache2/php.ini
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 1G/g' /etc/php5/apache2/php.ini
sed -i 's/post_max_size = 8M/post_max_size = 1G/g' /etc/php5/apache2/php.ini
sed -i 's/expose_php = On/expose_php = Off/g' /etc/php5/apache2/php.ini
sed -i 's/pm.max_children = 5/pm.max_children = 20/g' /etc/php5/fpm/pool.d/www.conf


#config des droits	
echo "www-data ALL=(ALL) NOPASSWD: ALL" | (EDITOR="tee -a" visudo)

#droits jeedom
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 775 /var/www/html

# redemarrage des services

service apache2 start
