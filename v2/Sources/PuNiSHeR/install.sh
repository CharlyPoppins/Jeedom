
#!/bin/sh
# SFY alias stef74
# Version jeedom 2.1.2 en chroot synology
# dans le chroot
# cd /tmp
# wget --no-check-certificate https://raw.githubusercontent.com/PuNiSHeR374/Jeedom/master/v2/Beta/install_mini.sh
# chmod+x install_mini.sh
# sh install_mini.sh
# Le port 1881 doit être non utilisé
# De preférence un chroot tout neuf avec un reboot du nas chroot a deja été installé.
# Avoir installé les drivers usb soit manuellement soit par le spk http://www.jadahl.com/domoticz_beta/packages/UsbSerialDrivers_3.0.9.spk
# Enocean don't work on 32bits
# Lors de l'install de apache repondre N a la question.

install_msg_fr() {
    msg_installer_welcome="*Bienvenue dans l'intallation de Jeedom sur Debian Chroot*"
    msg_usage1="Utilisation: $0 [<nom_du_webserver>]"
    msg_usage2="             nom_du_webserver peut être 'nginx' (par défaut)"
    msg_manual_install_nodejs_ARM="*        Installation manuelle de nodeJS pour ARM       *"
    msg_manual_install_nodejs_RPI="*     Installation manuelle de nodeJS pour Raspberry    *"
    msg_nginx_config="*                Configuration de NGINX                *"
    msg_question_install_jeedom="Etes-vous sûr de vouloir installer Jeedom ?"
    msg_warning_install_jeedom="Attention : ceci écrasera la configuration par défaut de ${ws_upname} si elle existe !"
    msg_warning_overwrite_jeedom="Attention : votre installation existante de Jeedom va être écrasée !"
    msg_yes="oui"
    msg_no="non"
    msg_yesno="oui / non : "
    msg_cancel_install="Annulation de l'installation"
    msg_answer_yesno="Répondez oui ou non"
    msg_install_deps="*             Installation des dépendances             *"
    msg_passwd_mysql="Quel mot de passe venez vous de taper (mot de passe root de la MySql) ?"
    msg_confirm_passwd_mysql="Confirmez vous que le mot de passe est :"
    msg_bad_passwd_mysql="Le mot de passe MySQL fourni est invalide !"
    msg_setup_dirs_and_privs="* Création des répertoires et mise en place des droits *"
    msg_copy_jeedom_files="*             Copie des fichiers de Jeedom             *"
    msg_unable_to_download_file="Impossible de télécharger le fichier"
    msg_config_db="*          Configuration de la base de données         *"
    msg_install_jeedom="*                Installation de Jeedom                *"
    msg_update_jeedom="*                Mise à jour de Jeedom                 *"
    msg_setup_cron="*                Mise en place du cron                 *"
    msg_setup_nodejs_service="*            Mise en place du service nodeJS           *"
    msg_startup_nodejs_service="*             Démarrage du service nodeJS              *"
    msg_post_install_actions="*             Action post installation                 *"
    msg_post_update_actions="*              Action post mise à jour                 *"
    msg_install_complete="*                Installation terminée                 *"
    msg_update_complete="*                Mise à jour terminée                  *"
    msg_or="ou"
    msg_login_info1="Vous pouvez vous connecter sur Jeedom en allant sur :"
    msg_login_info2="Vos identifiants sont :"
    msg_optimize_webserver_cache="*       Vérification de l'optimisation de cache        *"
    msg_php_version="PHP version trouvé : "
    msg_php_already_optimized="PHP est déjà optimisé, utilisation de : "
    msg_optimize_webserver_cache_apc="Installation de l'optimisation de cache APC"
    msg_optimize_webserver_cache_opcache="Installation de l'optimisation de cache Zend OpCache"
    msg_uptodate="est déjà installé et à jour"
    msg_needinstallupdate="nécessite une installation ou une mise à jour"
    msg_ask_install_nginx_ssl="Voules vous mettre en place un certification SSL auto signé"
    msg_nginx_ssl_config="*                 NGINX SSL configuration               *"
}

########################## Helper functions ############################


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


usage_help() {
    echo "${msg_usage1}"
    echo "${msg_usage2}"
    exit 1
}

check_nodejs_version() {
    # Check if nodeJS v0.10.25 (or higher) is installed.
    # Return 1 of true, 0 (or else) otherwise
    NODEJS_VERSION="`nodejs -v 2>/dev/null  | sed 's/["v]//g'`"
    is_version_greater_or_equal "${NODEJS_VERSION}" "0.10.0"
    RETVAL=$?
    case ${RETVAL} in
        1)
            # Already installed and up to date
            echo "===> nodeJS ${msg_uptodate}"
        ;;
        0)
            # continue...
            echo "===> nodeJS ${msg_needinstallupdate}"
        ;;
    esac

    return ${RETVAL}
}

install_nodejs() {
    # Check if nodeJS v0.10.7 is installed,
    # otherwise, try to install it from various sources
    check_nodejs_version
    [ $? -eq 1 ] && return
    if [ -f /usr/bin/raspi-config ]; then
	curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
	sudo apt-get install -y nodejs
        ln -s /usr/bin/nodejs /usr/bin/node
    else
        if [  -z "$1" -a $(uname -a | grep cubox | wc -l ) -eq 1 -a ${ARCH} = "armv7l" ]; then
            apt-get -y install nodejs
            ln -s /usr/bin/nodejs /usr/bin/node
        else
            curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
            sudo apt-get install -y nodejs
            ln -s /usr/bin/nodejs /usr/bin/node
        fi
    fi
    curl -L https://www.npmjs.org/install.sh | sh
}

install_dependency() {
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
apt-get -y install mysql-client-5.5
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
apt-get -y install unzip
apt-get -y install ca-certificates
apt-get -y install htop
apt-get -y install nano

install_nodejs

apt-get autoremove
}


# Select the right language, among available ones
setup_i18n

echo "********************************************************"
echo "${msg_installer_welcome}"
echo "********************************************************"


# Status sous syno de apache2 et demarrage des services
cd /home
wget --no-check-certificate https://raw.githubusercontent.com/PuNiSHeR374/Jeedom/master/v2/Sources/PuNiSHeR/jeedom.sh
chmod +x jeedom.sh

#recup config apache2 pour ne pas avoir de messages d'erreurs
#Faut repondre N lors de la question à l'install de apache2
cd /tmp
mkdir /etc/apache2/
wget --no-check-certificate https://raw.githubusercontent.com/PuNiSHeR374/Jeedom/master/v2/Sources/PuNiSHeR/apache2.conf
mv /tmp/apache2.conf /etc/apache2

chmod 777 /dev/tty*

install_dependency
	
echo "export LANG=fr_FR.utf8" >> ~/.bashrc
echo "export LC_ALL=fr_FR.utf8" >> ~/.bashrc

echo "cd /home" >> ~/.bashrc

# on se place dans le repertoire de travail
cd /tmp

#################################Perso########################################
# on recupere la Version 2.1.2
##############################################################################
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
