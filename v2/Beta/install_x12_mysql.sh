#!/bin/sh
#
# Installateur Synology x12 Series
#
# SFY alias stef74 & PuNiSHeR
# Version jeedom 2.x.x en chroot synology
#
# Dans le chroot :
# cd /tmp
# wget --no-check-certificate https://raw.githubusercontent.com/PuNiSHeR374/Jeedom/master/v2/Beta/install_x12_bis.sh
# chmod +x install_x12_bis.sh
# sh install_x12_bis.sh
#
# De preférence un chroot tout neuf avec un reboot du nas chroot a deja été installé.
# Avoir installé les drivers usb soit manuellement soit par le spk http://www.jadahl.com/domoticz_beta/packages/UsbSerialDrivers_3.0.9.spk
# Enocean don't work on 32bits.


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
	msg_yes="oui"
	msg_no="non"
	msg_installer_welcome="*Bienvenue dans l'intallation de Jeedom sur Debian Chroot*"
	msg_answer_yesno="Répondez oui ou non"
	msg_question_port="Quel Port désirez-vous utiliser pour nginx? : "
	msg_question_port_mysql="Quel Port désirez-vous utiliser pour mysql? (oui/non) :"
	msg_question_zwave="Désirez-vous utiliser le Protocol Z-wave ? (oui/non) : "
	msg_check_right="*       Controle des Droits sur les Dossiers          *"
	msg_dir_jeedom="Dossier Jeedom..."
	msg_dir_cache="Dossier Cache..."
	msg_port_already_used="Le Port 80 est deja utilise sur le Synology..."
	msg_choose_other_port="Veuillez choisir un autre Port."
	msg_your_port_choice="Vous avez choisi le Port : "
	msg_port_changing="Changement de Port en Cours..."
	msg_not_empty_port="Vous ne pouvez pas laisser le Port vide..."
	msg_restart_nginx="Redemarrage de Nginx..."
	msg_restart_mysql="Redemarrage de mysql..."
	msg_you_write="Vous avez introduit : "
	msg_only_numbers="Veuillez introduire que des chiffres."
	msg_del_apache_detected="Apache2 detecte, suppression en Cours..."
	msg_del_dir_apache="Dossier Apache2 detecte, suppression en Cours..."
	msg_del_dir_html="Dossier HTML detecte, suppression en Cours..."
	msg_check_apache="*      Verification de la Presence de Apache2         *"
	msg_port_greater="Port incorrecte. Uniquement un Port compris entre 1 - 65535."
	msg_space_detected="Vous avez insere un Espace dans le Numero de Port."
	msg_install_zwave="*          Installation dépendances Z-Wave            *"
	msg_install_mysql="*          Installation de mysql            *"
	msg_not_install_zwave="D'accord, vous n'utilisez pas le Protocol Z-Wave."
	msg_not_install_mysql="D'accord, vous n'utilisez pas mysql."
}


install_msg_en() {
	msg_yes="oui"
	msg_no="non"
	msg_installer_welcome="*      Welcome to the Jeedom installer/updater        *"
	msg_answer_yesno="Answer yes or no"
	msg_question_port="Quel Port désirez-vous utiliser ? : "
	msg_question_mysql="Désirez-vous installer mysql? :"
	msg_question_port_mysql="Quel Port désirez-vous utiliser pour mysql? (oui/non) :"
	msg_question_zwave="Désirez-vous utiliser le Protocol Z-wave ? (oui/non) : "
	msg_check_right="*       Controle des Droits sur les Dossiers          *"
	msg_dir_jeedom="Folder Jeedom..."
	msg_dir_cache="Folder Cache..."
	msg_port_already_used="Le Port 80 est deja utilise sur le Synology..."
	msg_choose_other_port="Veuillez choisir un autre Port."
	msg_your_port_choice="Vous avez choisi le Port : "
	msg_port_changing="Changement de Port en Cours..."
	msg_not_empty_port="Vous ne pouvez pas laisser le Port vide..."
	msg_restart_nginx="Redemarrage de Nginx..."
	msg_restart_mysql="Redemarrage de mysql..."
	msg_you_write="Vous avez introduit : "
	msg_only_numbers="Veuillez introduire que des chiffres."
	msg_del_apache_detected="Apache2 detecte, suppression en Cours..."
	msg_del_dir_apache="Dossier Apache2 detecte, suppression en Cours..."
	msg_del_dir_html="Dossier HTML detecte, suppression en Cours..."
	msg_check_apache="*      Verification de la Presence de Apache2         *"
	msg_port_greater="Port incorrecte. Uniquement un Port compris entre 1 - 65535."
	msg_space_detected="Vous avez insere un Espace dans le Numero de Port."
	msg_install_zwave="*          Installation dépendances Z-Wave            *"
	msg_install_mysql="*          Installation de mysql            *"
	msg_not_install_zwave="D'accord, vous n'utilisez pas le Protocol Z-Wave."
	msg_not_install_mysql="D'accord, vous n'utilisez pas mysql."
}


install_msg_de() {
	msg_yes="oui"
	msg_no="non"
	msg_installer_welcome="*      Willkommen beim Jeedom Installer / Updater        *"
	msg_answer_yesno="Antwort ja oder nein"
	msg_question_port="Quel Port désirez-vous utiliser ? : "
	msg_question_port_mysql="Quel Port désirez-vous utiliser pour mysql? (oui/non) :"
	msg_question_mysql="Désirez-vous installer mysql? :"
	msg_question_zwave="Désirez-vous utiliser le Protocol Z-wave ? (oui/non) : "
	msg_check_right="*       Controle des Droits sur les Dossiers          *"
	msg_dir_jeedom="Dossier Jeedom..."
	msg_dir_cache="Dossier Cache..."
	msg_port_already_used="Le Port 80 est deja utilise sur le Synology..."
	msg_choose_other_port="Veuillez choisir un autre Port."
	msg_your_port_choice="Vous avez choisi le Port : "
	msg_port_changing="Changement de Port en Cours..."
	msg_not_empty_port="Vous ne pouvez pas laisser le Port vide..."
	msg_restart_nginx="Redemarrage de Nginx..."
	msg_restart_mysql="Redemarrage de mysql..."
	msg_you_write="Vous avez introduit : "
	msg_only_numbers="Veuillez introduire que des chiffres."
	msg_del_apache_detected="Apache2 detecte, suppression en Cours..."
	msg_del_dir_apache="Dossier Apache2 detecte, suppression en Cours..."
	msg_del_dir_html="Dossier HTML detecte, suppression en Cours..."
	msg_check_apache="*      Verification de la Presence de Apache2         *"
	msg_port_greater="Port incorrecte. Uniquement un Port compris entre 1 - 65535."
	msg_space_detected="Vous avez insere un Espace dans le Numero de Port."
	msg_install_zwave="*          Installation dépendances Z-Wave            *"
	msg_install_mysql="*          Installation de mysql            *"
	msg_not_install_zwave="D'accord, vous n'utilisez pas le Protocol Z-Wave."
	msg_not_install_mysql="D'accord, vous n'utilisez pas mysql."
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
	apt-get -y install ntp
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

	pecl install oauth
	if [ $? -eq 0 ] ; then
		for i in fpm cli ; do
			PHP_OAUTH="`cat /etc/php5/${i}/php.ini | grep -e 'oauth.so'`"
			if [ -z "${PHP_OAUTH}" ] ; then
				echo "extension=oauth.so" >> /etc/php5/${i}/php.ini
			fi
		done
	fi
}


configure_nginx() {
	echo ""; echo "";
	echo -n "${msg_question_port}"
	read answer

	if [ "$(echo $answer | grep "^[ [:digit:] ]*$")" ]
	then
		if [ "$(echo $answer | grep -o ' ' | wc -l)" -ne 0 ]; then
			echo ""; echo "";
			echo "${msg_space_detected}";
			configure_nginx
		elif [ $answer -gt 65535 ]; then
			echo ""; echo "";
			echo "${msg_port_greater}";
			configure_nginx
		elif [ $answer -eq 80 ]; then
			echo ""; echo "";
			echo "${msg_port_already_used}";
			echo "${msg_choose_other_port}";
			configure_nginx
		else
			echo ""; echo "";
			echo "${msg_your_port_choice}"$answer;
			echo "${msg_port_changing}";
			echo ""; echo "";
			sed -i 's/#listen   80;/listen '"$answer"';/g' /etc/nginx/sites-available/default
			sed -i 's/#listen   \[\:\:\]\:80/listen \[\:\:\]\:'"$answer"'/g' /etc/nginx/sites-available/default

			if [ -f '/etc/nginx/sites-enabled/default' ] ; then
				rm /etc/nginx/sites-enabled/default
				cp /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
			fi

			if [ ! -f '/etc/nginx/sites-available/jeedom_dynamic_rule' ] ; then
				touch /etc/nginx/sites-available/jeedom_dynamic_rule
			fi
			chmod 777 /etc/nginx/sites-available/jeedom_dynamic_rule

			echo "${msg_restart_nginx}";

			service nginx start
			
			update-rc.d nginx defaults
		fi
	elif [ -z $answer ]; then
		echo ""; echo "";
		echo "${msg_not_empty_port}";
		configure_nginx

	else
		echo ""; echo "";
		echo "${msg_you_write}"$answer;
		echo "";
		echo "${msg_only_numbers}";
		configure_nginx
	fi
}



check_apache2() {
	echo ""; echo "";
	echo "**********************************************************"
	echo "${msg_check_apache}"
	echo "**********************************************************"
	echo "";

	dpkg-query -l apache2 > /dev/null;

	if [ $? -eq 0 ] ; then
		echo "";
		echo "${msg_del_apache_detected}";
		service apache2 stop
		apt-get -y autoremove --purge apache2
	fi

	if [ -d "/etc/apache2" ]; then
		echo "";
		echo "${msg_del_dir_apache}";
		rm -Rf /etc/apache2
	fi

	if [ -d "/var/www/html" ]; then
		echo "";
		echo "${msg_del_dir_html}";
		rm -Rf /var/www/html
	fi
}


configure_php() {
	sed -i 's/max_execution_time = 30/max_execution_time = 600/g' /etc/php5/fpm/php.ini
	sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 1G/g' /etc/php5/fpm/php.ini
	sed -i 's/post_max_size = 8M/post_max_size = 1G/g' /etc/php5/fpm/php.ini
	sed -i 's/expose_php = On/expose_php = Off/g' /etc/php5/fpm/php.ini
	sed -i 's/pm.max_children = 5/pm.max_children = 20/g' /etc/php5/fpm/pool.d/www.conf
}

install_mysql() {
	while true ; do
		echo ""; echo "";
		echo -n "${msg_question_mysql}"
		read answer

		case $answer in
			${msg_yes})
				echo ""; echo "";
				echo "**********************************************************"
				echo "${msg_install_mysql}"
				echo "**********************************************************"
				echo ""; echo "";
				apt-get -y install mysql-common
				apt-get -y install mysql-server
				apt-get -y install mysql-server-core-5.5
				configure_mysql
				break
			;;
			${msg_no})
				echo ""; echo "";
				echo "${msg_not_install_mysql}";
				break
			;;
		esac
		echo "";
	done
}

configure_mysql() {
	echo ""; echo "";
	echo -n "${msg_question_port_mysql}"
	read answer

	if [ "$(echo $answer | grep "^[ [:digit:] ]*$")" ]
	then
		if [ "$(echo $answer | grep -o ' ' | wc -l)" -ne 0 ]; then
			echo ""; echo "";
			echo "${msg_space_detected}";
			configure_mysql
		elif [ $answer -gt 65535 ]; then
			echo ""; echo "";
			echo "${msg_port_greater}";
			configure_mysql
		elif [ $answer -eq 80 ]; then
			echo ""; echo "";
			echo "${msg_port_already_used}";
			echo "${msg_choose_other_port}";
			configure_mysql
		else
			echo ""; echo "";
			echo "${msg_your_port_choice}"$answer;
			echo "${msg_port_changing}";
			echo ""; echo "";
			service mysql stop
			# A faire changer le port mysql
			
			

			echo "${msg_restart_mysql}";

			service mysql start
			
			#update-rc.d nginx defaults
		fi
	elif [ -z $answer ]; then
		echo ""; echo "";
		echo "${msg_not_empty_port}";
		configure_mysql

	else
		echo ""; echo "";
		echo "${msg_you_write}"$answer;
		echo "";
		echo "${msg_only_numbers}";
		configure_mysql
	fi
}


install_zwave() {
	while true ; do
		echo ""; echo "";
		echo -n "${msg_question_zwave}"
		read answer

		case $answer in
			${msg_yes})
				echo ""; echo "";
				echo "**********************************************************"
				echo "${msg_install_zwave}"
				echo "**********************************************************"
				echo ""; echo "";
				wget --no-check-certificate https://raw.githubusercontent.com/PuNiSHeR374/Jeedom/master/v2/Release/Chroot/install_zwave.sh
				chmod +x install_zwave.sh
				./install_zwave.sh
				break
			;;
			${msg_no})
				echo ""; echo "";
				echo "${msg_not_install_zwave}";
				break
			;;
		esac
		echo "";
	done
}


check_right() {
	echo ""; echo "";
	echo "**********************************************************"
	echo "${msg_check_right}"
	echo "**********************************************************"
	echo "";
	chown -R www-data:www-data /var/www/html

	echo "${msg_dir_jeedom}"
	echo -n "[$(date +%d-%m-%Y\ %H:%M:%S)] Dossier Jeedom..."
	chown -R www-data:www-data /var/www/html
	chmod 775 -R /var/www/html
	echo "OK"

	echo "${msg_dir_cache}"
	echo -n "[$(date +%d-%m-%Y\ %H:%M:%S)] Dossier Cache..."
	chmod 775 -R /tmp/jeedom-cache
	echo "OK"
}


# Selection de la Langue
setup_i18n

echo ""; echo "";
echo "**********************************************************"
echo "${msg_installer_welcome}"
echo "**********************************************************"
echo ""; echo "";


# Vérification qu'on est bien en root
if [ $(id -u) != 0 ] ; then
	echo "Super-user (root) privileges are required to install Jeedom"
	echo "Please run 'sudo $0' or log in as root, and rerun $0"
	exit 1
fi


# Installation des dépandences
install_dependency


echo "export LANG=fr_FR.utf8" >> ~/.bashrc
echo "export LC_ALL=fr_FR.utf8" >> ~/.bashrc

echo "cd /home" >> ~/.bashrc


# Vérification de la présence de Apache2
check_apache2


# Installation du Serveur Web
install_webserver


# Configuration Port Virtualhost Nginx
if [ -f '/etc/nginx/sites-available/defaults' ] ; then
	rm /etc/nginx/sites-available/default
fi

cd /tmp
wget --no-check-certificate https://raw.githubusercontent.com/PuNiSHeR374/Jeedom/master/v2/Beta/nginx_x12.conf

service nginx stop

mv nginx_x12.conf /etc/nginx/sites-available/default

configure_nginx

# Installation de mysql
install_mysql

# Configuration de PHP
configure_php


# Installation Z-Wave
install_zwave


# Status sous syno de Nginx et demarrage des services Jeedom
cd /home

if [ -f "/home/jeedom.sh" ];then
	rm /home/jeedom.sh
fi

wget --no-check-certificate https://raw.githubusercontent.com/PuNiSHeR374/Jeedom/master/v2/Beta/jeedom_x12.sh
mv jeedom_x12.sh jeedom.sh
chmod +x jeedom.sh

service nginx stop

rm /var/www/html/index.html


#config des droits	
echo "www-data ALL=(ALL) NOPASSWD: ALL" | (EDITOR="tee -a" visudo)


#config du cron
croncmd="su --shell=/bin/bash - www-data -c '/usr/bin/php /var/www/html/core/php/jeeCron.php' >> /dev/null"
cronjob="* * * * * $croncmd"
( crontab -l | grep -v "$croncmd" ; echo "$cronjob" ) | crontab -


# Changement des droits
check_right

service php5-fpm restart


# D'apres la doc jeedom
mkdir -p /var/www/html
rm -rf /root/core-*
wget https://github.com/jeedom/core/archive/stable.zip -O /tmp/jeedom.zip
unzip -q /tmp/jeedom.zip -d /root/
cp -R /root/core-*/* /var/www/html/
cp -R /root/core-*/.htaccess /var/www/html/

rm /tmp/jeedom.zip


# Redémarrage des services
service cron restart
service nginx restart
