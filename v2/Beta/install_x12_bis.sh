#!/bin/sh
#
# Installateur Synology x12 Series
#
# SFY alias stef74
# Version jeedom 2.x.x en chroot synology
#
# Dans le chroot :
# cd /tmp
# wget --no-check-certificate https://raw.githubusercontent.com/PuNiSHeR374/Jeedom/master/v2/Beta/install_x12_bis.sh
# chmod+x install_x12.sh
# sh install_x12.sh
#
# De preférence un chroot tout neuf avec un reboot du nas chroot a deja été installé.
# Avoir installé les drivers usb soit manuellement soit par le spk http://www.jadahl.com/domoticz_beta/packages/UsbSerialDrivers_3.0.9.spk
# Enocean don't work on 32bits


setup_i18n() {
    lang=${LANG:=en_US}
    case ${lang} in
        [Ff][Rr]*)
            install_msg_fr
        ;;
        [Ee][Nn]*|*)
            install_msg_en
        ;;
        [De][De]*|*)
            install_msg_de
        ;;
    esac
}


install_msg_fr() {
    msg_installer_welcome="*Bienvenue dans l'intallation de Jeedom sur Debian Chroot*"
    msg_answer_yesno="Répondez oui ou non"
	msg_question_port="Quel Port désirez-vous utiliser ? "
}


install_msg_en() {
    msg_installer_welcome="*      Welcome to the Jeedom installer/updater        *"
    msg_answer_yesno="Answer yes or no"
	msg_question_port="Quel Port désirez-vous utiliser ? "
}


install_msg_de() {
    msg_installer_welcome="*      Willkommen beim Jeedom Installer / Updater        *"
    msg_answer_yesno="Antwort ja oder nein"
	msg_question_port="Quel Port désirez-vous utiliser ? "
}


install_dependency() {
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
apt-get -y install unzip
apt-get -y install htop
apt-get -y install nano
}


install_webserver() {
apt-get -y install mysql-client
apt-get -y install nginx
apt-get -y install php5-fpm
apt-get -y install php5-curl
apt-get -y install php5-dev
apt-get -y install php5-json
apt-get -y install php5-mysql
apt-get -y install php5-ldap
apt-get -y install php5-gd
apt-get -y install php-pear
apt-get -y install ca-certificates
}


configure_nginx() {
echo -n "${msg_question_port}"
read answer
echo "Changement de Port en Cours...";
sed -i 's/listen 80 default_server;/listen '"$answer"' default_server;/g' /etc/nginx/sites-enabled/default
sed -i 's/listen \[\:\:\]\:80 default_server;/listen \[\:\:\]\:'"$answer"' default_server;/g' /etc/nginx/sites-enabled/default
fi
echo "Redemarrage de Nginx...";
service nginx stop
service nginx start
}


#configure_php() {
#sed -i 's/max_execution_time = 30/max_execution_time = 600/g' /etc/php5/apache2/php.ini
#sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 1G/g' /etc/php5/apache2/php.ini
#sed -i 's/post_max_size = 8M/post_max_size = 1G/g' /etc/php5/apache2/php.ini
#sed -i 's/expose_php = On/expose_php = Off/g' /etc/php5/apache2/php.ini
#sed -i 's/pm.max_children = 5/pm.max_children = 20/g' /etc/php5/fpm/pool.d/www.conf
#}


# Selection de la Langue
setup_i18n


echo "**********************************************************"
echo "${msg_installer_welcome}"
echo "**********************************************************"


# Installation des dépandences
install_dependency


echo "export LANG=fr_FR.utf8" >> ~/.bashrc
echo "export LC_ALL=fr_FR.utf8" >> ~/.bashrc

echo "cd /home" >> ~/.bashrc


# Vérification de la présence de Apache2
dpkg-query -l apache2 > /dev/null;

if [ $? -eq 0 ] ; then
	echo "Apache2 detecte, suppression en Cours...";
	service apache2 stop
	apt-get -y autoremove --purge apache2
fi

if [ -d "/etc/apache2" ];then
	echo "Dossier Apache2 detecte, suppression en Cours...";
	rm -Rf /etc/apache2
fi

if [ -d "/var/www/html" ];then
	echo "Dossier HTML detecte, suppression en Cours...";
	rm -Rf /var/www/html
fi



# Installation du Serveur Web
install_webserver


# On se place dans le dossier TMP
cd /tmp


# Modification du Fichier config de Nginx
rm /etc/nginx/default

wget --no-check-certificate https://raw.githubusercontent.com/PuNiSHeR374/Jeedom/master/v2/Beta/nginx_x12.conf

mv nginx_x12.conf /etc/nginx/default


# Configuration Port Nginx
configure_nginx
















# Status sous syno de Nginx et demarrage des services
cd /home

wget --no-check-certificate https://raw.githubusercontent.com/PuNiSHeR374/Jeedom/master/v2/Beta/jeedom_x12.sh
mv jeedom_x12.sh jeedom.sh
chmod +x jeedom.sh



#wget https://raw.githubusercontent.com/jeedom/core/stable/install/apache_security -O /etc/apache2/conf-available/security.conf
#rm /etc/apache2/conf-enabled/security.conf
#ln -s /etc/apache2/conf-available/security.conf /etc/apache2/conf-enabled/

#rm /var/www/html/index.html



#config des droits	
echo "www-data ALL=(ALL) NOPASSWD: ALL" | (EDITOR="tee -a" visudo)

#droits jeedom
sudo chown -R www-data:www-data /var/www/html
#sudo chmod -R 775 /var/www/html

# redemarrage des services

#service cron restart
