#!/bin/bash
#
# Installateur Jeedom v2.x.x
# Synology Debian Chroot
#
# SFY alias stef74 & PuNiSHeR
#
# Dans le chroot :
# cd /tmp
# wget --no-check-certificate https://raw.githubusercontent.com/PuNiSHeR374/Jeedom/master/v2/Beta/install_x12.sh
# chmod+x install_x12.sh
# sh install_x12.sh
#
# De preférence un chroot tout neuf avec un reboot du nas chroot a deja été installé.
# Avoir installé les drivers usb soit manuellement soit par le spk http://www.jadahl.com/domoticz_beta/packages/UsbSerialDrivers_3.0.9.spk
# Enocean don't work on 32bits.

dpkg-query -s dialog > /dev/null;

if [ $? -ne 0 ] ; then
	apt-get -y install Dialog
fi


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
	msg_question_port="Quel Port désirez-vous utiliser ? : "
	msg_question_zwave="Désirez-vous utiliser le Protocol Z-wave ? (oui/non) : "
	msg_check_right="*         Controle des Droits sur les Dossiers           *"
	msg_dir_jeedom="Dossier Jeedom : "
	msg_dir_cache="Dossier Cache : "
	msg_port_already_used="Le Port 80 est deja utilise sur le Synology..."
	msg_choose_other_port="Veuillez choisir un autre Port."
	msg_your_port_choice="Vous avez choisi le Port : "
	msg_port_changing="Changement de Port en Cours..."
	msg_change_port_ok="Remplacement du Port : OK"
	msg_not_empty_port="Vous ne pouvez pas laisser le Port vide..."
	msg_restart_nginx="Redemarrage de Nginx..."
	msg_you_write="Vous avez introduit : "
	msg_only_numbers="Veuillez introduire que des chiffres."
	msg_del_apache_detected="Apache2 detecte, suppression en Cours..."
	msg_del_dir_apache="Dossier Apache2 detecte, suppression en Cours..."
	msg_del_dir_html="Dossier HTML detecte, suppression en Cours..."
	msg_check_apache="*      Verification de la Presence de Apache2         *"
	msg_port_greater="Port incorrecte. Uniquement un Port compris entre 1 - 65535."
	msg_space_detected="Vous avez insere un Espace dans le Numero de Port."
	msg_install_zwave="*          Installation dépendances Z-Wave            *"
	msg_not_install_zwave="D'accord, vous n'utilisez pas le Protocol Z-Wave."
}


install_msg_en() {
	msg_yes="oui"
	msg_no="non"
	msg_installer_welcome="*      Welcome to the Jeedom installer/updater        *"
	msg_answer_yesno="Answer yes or no"
	msg_question_port="Quel Port désirez-vous utiliser ? : "
	msg_question_zwave="Désirez-vous utiliser le Protocol Z-wave ? (oui/non) : "
	msg_check_right="*         Controle des Droits sur les Dossiers           *"
	msg_dir_jeedom="Dossier Jeedom : "
	msg_dir_cache="Dossier Cache : "
	msg_port_already_used="Le Port 80 est deja utilise sur le Synology..."
	msg_choose_other_port="Veuillez choisir un autre Port."
	msg_your_port_choice="Vous avez choisi le Port : "
	msg_port_changing="Changement de Port en Cours..."
	msg_change_port_ok="Remplacement du Port : OK"
	msg_not_empty_port="Vous ne pouvez pas laisser le Port vide..."
	msg_restart_nginx="Redemarrage de Nginx..."
	msg_you_write="Vous avez introduit : "
	msg_only_numbers="Veuillez introduire que des chiffres."
	msg_del_apache_detected="Apache2 detecte, suppression en Cours..."
	msg_del_dir_apache="Dossier Apache2 detecte, suppression en Cours..."
	msg_del_dir_html="Dossier HTML detecte, suppression en Cours..."
	msg_check_apache="*      Verification de la Presence de Apache2         *"
	msg_port_greater="Port incorrecte. Uniquement un Port compris entre 1 - 65535."
	msg_space_detected="Vous avez insere un Espace dans le Numero de Port."
	msg_install_zwave="*          Installation dépendances Z-Wave            *"
	msg_not_install_zwave="D'accord, vous n'utilisez pas le Protocol Z-Wave."
}


install_msg_de() {
	msg_yes="oui"
	msg_no="non"
	msg_installer_welcome="*      Willkommen beim Jeedom Installer / Updater        *"
	msg_answer_yesno="Antwort ja oder nein"
	msg_question_port="Quel Port désirez-vous utiliser ? : "
	msg_question_zwave="Désirez-vous utiliser le Protocol Z-wave ? (oui/non) : "
	msg_check_right="*         Controle des Droits sur les Dossiers           *"
	msg_dir_jeedom="Dossier Jeedom : "
	msg_dir_cache="Dossier Cache : "
	msg_port_already_used="Le Port 80 est deja utilise sur le Synology..."
	msg_choose_other_port="Veuillez choisir un autre Port."
	msg_your_port_choice="Vous avez choisi le Port : "
	msg_port_changing="Changement de Port en Cours..."
	msg_change_port_ok="Remplacement du Port : OK"
	msg_not_empty_port="Vous ne pouvez pas laisser le Port vide..."
	msg_restart_nginx="Redemarrage de Nginx..."
	msg_you_write="Vous avez introduit : "
	msg_only_numbers="Veuillez introduire que des chiffres."
	msg_del_apache_detected="Apache2 detecte, suppression en Cours..."
	msg_del_dir_apache="Dossier Apache2 detecte, suppression en Cours..."
	msg_del_dir_html="Dossier HTML detecte, suppression en Cours..."
	msg_check_apache="*      Verification de la Presence de Apache2         *"
	msg_port_greater="Port incorrecte. Uniquement un Port compris entre 1 - 65535."
	msg_space_detected="Vous avez insere un Espace dans le Numero de Port."
	msg_install_zwave="*          Installation dépendances Z-Wave            *"
	msg_not_install_zwave="D'accord, vous n'utilisez pas le Protocol Z-Wave."
}


install_dependency() {

	chmod 777 /dev/tty* 2>&1 | dialog --gauge --stdout --stderr "chmod 777 /dev/tty*" 7 50 5
	apt-get update 2>&1 | dialog --gauge --stdout --stderr "apt-get update" 7 50 10
	apt-get -y install locales 2>&1 | dialog --gauge --stdout --stderr "Installation Package : locales" 7 50 20
	dpkg-reconfigure locales
	dpkg-reconfigure tzdata
	apt-get -y upgrade 2>&1 | dialog --gauge --stdout --stderr "apt-get -y upgrade" 7 50 30
	apt-get -y install build-essential 2>&1 | dialog --gauge --stdout --stderr "Installation Package : build-essential" 7 50 40
	apt-get -y install sudo 2>&1 | dialog --gauge --stdout --stderr "Installation Package : sudo" 7 50 50
	apt-get -y install curl 2>&1 | dialog --gauge --stdout --stderr "Installation Package : curl" 7 50 60
	apt-get -y install make 2>&1 | dialog --gauge --stdout --stderr "Installation Package : make" 7 50 65
	apt-get -y install mc 2>&1 | dialog --gauge --stdout --stderr "Installation Package : mc" 7 50 70
	apt-get -y install vim 2>&1 | dialog --gauge --stdout --stderr "Installation Package : vim" 7 50 75
	apt-get -y install unzip 2>&1 | dialog --gauge --stdout --stderr "Installation Package : unzip" 7 50 80
	apt-get -y install htop 2>&1 | dialog --gauge --stdout --stderr "Installation Package : htop" 7 50 85
	apt-get -y install nano 2>&1 | dialog --gauge --stdout --stderr "Installation Package : nano" 7 50 90
	apt-get -y install ntp 2>&1 | dialog --gauge --stdout --stderr "Installation Package : ntp" 7 50 95
	dialog --gauge --stdout --stderr "Installation des dependances, termine" 7 50 100
	sleep 3
}


install_webserver() {
	apt-get -y install mysql-client 2>&1 | dialog --gauge --stdout --stderr "Installation Package : mysql-client" 7 50 5
	apt-get -y install nginx 2>&1 | dialog --gauge --stdout --stderr "Installation Package : nginx" 7 50 10
	apt-get -y install php5-fpm 2>&1 | dialog --gauge --stdout --stderr "Installation Package : php5-fpm" 7 50 20
	apt-get -y install php5-curl 2>&1 | dialog --gauge --stdout --stderr "Installation Package : php5-curl" 7 50 30
	apt-get -y install php5-dev 2>&1 | dialog --gauge --stdout --stderr "Installation Package : php5-dev" 7 50 40
	apt-get -y install php5-json 2>&1 | dialog --gauge --stdout --stderr "Installation Package : php5-json" 7 50 50
	apt-get -y install php5-mysql 2>&1 | dialog --gauge --stdout --stderr "cInstallation Package : php5-mysql" 7 50 60
	apt-get -y install php5-ldap 2>&1 | dialog --gauge --stdout --stderr "Installation Package : php5-ldap" 7 50 70
	apt-get -y install php5-gd 2>&1 | dialog --gauge --stdout --stderr "Installation Package : php5-gd" 7 50 80
	apt-get -y install php-pear 2>&1 | dialog --gauge --stdout --stderr "cInstallation Package : php-pear" 7 50 90
	apt-get -y install ca-certificates 2>&1 | dialog --gauge --stdout --stderr "Installation Package : ca-certificates" 7 50 95
	dialog --gauge --stdout --stderr "Installation Serveur Web, Termine." 7 50 100
	sleep 3

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

change_port() {
	exec 3>&1
	PORT=$(dialog --clear --backtitle "$BACKTITLE" \
			--title "$TITLE" \
			--inputbox "\nQuel Port desirez-vous utiliser ?\n" 10 40 "" \
			2>&1 1>&3 >/dev/tty)
	exec 3>&-


	if [ "$(echo $PORT | grep "^[ [:digit:] ]*$")" ]
	then
		if [ "$(echo $PORT | grep -o ' ' | wc -l)" -ne 0 ]; then
			echo ""; echo "";
			info="${msg_space_detected}"
			change_port
		elif [ $PORT -gt 65535 ]; then
			echo ""; echo "";
			echo "${msg_port_greater}";
			change_port
		elif [ $PORT -eq 80 ]; then
			echo ""; echo "";
			echo "${msg_port_already_used}";
			echo "${msg_choose_other_port}";
			change_port
		else
			echo "";
			echo "${msg_your_port_choice}"$PORT;
			echo "";

			PostValue Port $PORT

			sed -i '2d;3d' /etc/nginx/sites-available/default
			sleep 2
			sed -i -e '2i\	listen '"$PORT"'; ## listen for ipv4; this line is default and implied' /etc/nginx/sites-available/default
			sed -i -e '3i\	listen \[\:\:\]\:'"$PORT"' default_server ipv6only=on; ## listen for ipv6' /etc/nginx/sites-available/default

			if [ -f '/etc/nginx/sites-enabled/default' ] ; then
				rm /etc/nginx/sites-enabled/default
				cp /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
			fi

			echo "${msg_change_port_ok}";
			echo "";
			echo "${msg_restart_nginx}";
			echo "";
			service nginx restart
			echo "";
			service php5-fpm restart
		fi
	elif [ -z $PORT ]; then
		echo ""; echo "";
		echo "${msg_not_empty_port}";
		change_port

	else
		info="\n" \
			"${msg_you_write}"$PORT \
			"\n" \
			"${msg_only_numbers}";
		change_port
	fi
}


configure_nginx() {
	if [ ! -f '/etc/nginx/sites-available/jeedom_dynamic_rule' ] ; then
		touch /etc/nginx/sites-available/jeedom_dynamic_rule
	fi
	chmod 777 /etc/nginx/sites-available/jeedom_dynamic_rule

	echo "${msg_restart_nginx}";

	service nginx start

	update-rc.d nginx defaults
}


check_apache2() {
	echo ""; echo "";
	echo "**********************************************************"
	echo "${msg_check_apache}"
	echo "**********************************************************"
	echo "";

	#if [ $(ps ax | grep z-way-server | grep -v grep | wc -l ) -ne 0 ]; then
	dpkg-query -s apache2 > /dev/null;

	if [ $? -ne 0 ] ; then
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
	echo "";
	chown -R www-data:www-data /var/www/html

	echo -n "[$(date +%d-%m-%Y\ %H:%M:%S)] ${msg_dir_jeedom}"
	chown -R www-data:www-data /var/www/html
	chmod 775 -R /var/www/html
	echo "OK"
	echo "";
	echo -n "[$(date +%d-%m-%Y\ %H:%M:%S)] ${msg_dir_cache}"
	chmod 775 -R /tmp/jeedom-cache
	echo "OK"
	echo "";
}


PostValue() {
	PARAM=$1
	VALUE=$2

	result=$(grep $PARAM $ParamFile)
	if [ $? -ne 0 ]; then
		echo $PARAM'='$VALUE >> $ParamFile
	else
		sed -i "s/${PARAM}\=.*/${PARAM}\=${VALUE}/" $ParamFile
	fi
}


GetValue() {
	PARAM=$1
	VALUE=$(sed -rn "s/^\s*${PARAM}\s*=\s*(.*)$/\1/p" ParamFile)
	echo $VALUE
}


ShowResult() {
	dialog --title "$1" \
		--no-collapse \
		--ok-label "Ok" \
		--msgbox "$result" 0 0
}


Warning() {
	dialog --title "!! ATTENTION !!" \
		--no-collapse \
		--ok-label "Ok" \
		--msgbox "$info" 0 0
}


menu_select_hardware() {
# Hauteur Menu
MENU_HEIGHT=3

# Hauteur MsgBox
HEIGHT=15

# Phrase Box
MENU="\nQuel est votre modele de Synology ?\n "


CHOIX=$(dialog --clear --backtitle "$BACKTITLE" --title "$TITLE" --menu "$MENU" $HEIGHT $WIDTH $MENU_HEIGHT \
"1" "Synology - Series x12" \
"2" "Synology - Series Autre" \
2>&1 >/dev/tty)

case $CHOIX in
	1)
		PostValue Hardware x12
		menu_select_job
	;;
	2)
		PostValue Hardware Other
		menu_select_job
	;;
esac
}


menu_select_job(){
# Hauteur MsgBox
HEIGHT=25

# Hauteur Menu
MENU_HEIGHT=10

# Phrase Box
MENU="\nQu'est ce que vous desirez faire ?\n "

CHOIX=$(dialog --clear --backtitle "$BACKTITLE" --title "$TITLE" --menu "$MENU" $HEIGHT $WIDTH $MENU_HEIGHT \
"1" "Nouvelle Installation" \
"2" "Changer le Port d'ecoute" \
"3" "Verifier les droits des Dossiers" \
"4" "Changer Infos Base de Données" \
"5" "Creer Alias Debian" \
"6" "Creer Lien Symbolique (Dossier sur le reseau)" \
"7" "Installer Node Js" \
"8" "Installer xPL_Hub" \
"9" "Installer Pre-requis Z-Wave" \
2>&1 >/dev/tty)

case $CHOIX in
	1)

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

		change_port

		configure_nginx


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
	;;
	2)
		result=$(change_port)
		ShowResult "${msg_port_changing}"
	;;
	3)
		result=$(check_right)
		ShowResult "${msg_check_right}"
	;;
	4)
		echo "Option 4"

	;;
	5)	
		GetValue Hardware
	;;
esac
}


ParamFile="/tmp/SaveValue"

# Selection de la Langue
setup_i18n

# Largeur MsgBox
WIDTH=60

# Titre de Fond
BACKTITLE="Synology Debian Chroot"

# Titre Box
TITLE="Installation Jeedom v2.x.x"

#Démarrage du Menu Hardware
menu_select_hardware