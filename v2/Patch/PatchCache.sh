#!/bin/sh

echo ""; echo "";
echo "**********************************************************"
echo "Patch Jeedom v2.4.6"
echo ""
echo "Démarrage du Correctif du Cache Jeedom."
echo "**********************************************************"
echo "";

while true ; do
	echo ""; echo "";
	echo -n "Est ce que l'URL de votre serveur contient /jeedom ? (oui/non) : "
	read answer

	case $answer in
		oui)
			echo ""; echo "";
			PATH_JEEDOM="/var/www/html/jeedom"
			break
		;;
		non)
			echo ""; echo "";
			PATH_JEEDOM="/var/www/html"
			break
		;;
	esac
	echo "";
done


echo ""; echo "";
echo "**********************************************************"
echo "Backup de Jeedom."
echo "**********************************************************"
echo "";

sudo php ${PATH_JEEDOM}/install/backup.php

echo ""; echo "";
echo "**********************************************************"
echo "Backup des fichiers à Patcher."
echo "**********************************************************"
echo "";

sudo chown -R www-data:www-data /var/www
sudo chmod 0777 -R /var/www

sudo cp -v -p ${PATH_JEEDOM}/core/class/cache.class.php ${PATH_JEEDOM}/core/class/cache.class.php.bck
sudo cp -v -p ${PATH_JEEDOM}/core/cmd.class.php ${PATH_JEEDOM}/core/class/cmd.class.php.bck
sudo cp -v -p ${PATH_JEEDOM}/core/class/cron.class.php ${PATH_JEEDOM}/core/class/cron.class.php.bck
sudo cp -v -p ${PATH_JEEDOM}/core/class/eqLogic.class.php ${PATH_JEEDOM}/core/class/eqLogic.class.php.bck
sudo cp -v -p ${PATH_JEEDOM}/core/class/scenario.class.php ${PATH_JEEDOM}/core/class/scenario.class.php.bck
sudo cp -v -p ${PATH_JEEDOM}/install/consistency.php ${PATH_JEEDOM}/install/consistency.php.bck

echo ""; echo "";
echo "**********************************************************"
echo "Téléchargement des fichiers Patchés."
echo "**********************************************************"
echo "";

sudo mkdir /home/patch

sudo wget --no-check-certificate https://raw.githubusercontent.com/PuNiSHeR374/Jeedom/master/v2/Patch/cache.class.php -O /home/patch/cache.class.php
sudo wget --no-check-certificate https://raw.githubusercontent.com/PuNiSHeR374/Jeedom/master/v2/Patch/cmd.class.php -O /home/patch/cmd.class.php
sudo wget --no-check-certificate https://raw.githubusercontent.com/PuNiSHeR374/Jeedom/master/v2/Patch/cron.class.php -O /home/patch/cron.class.php
sudo wget --no-check-certificate https://raw.githubusercontent.com/PuNiSHeR374/Jeedom/master/v2/Patch/eqLogic.class.php -O /home/patch/eqLogic.class.php
sudo wget --no-check-certificate https://raw.githubusercontent.com/PuNiSHeR374/Jeedom/master/v2/Patch/scenario.class.php -O /home/patch/scenario.class.php
sudo wget --no-check-certificate https://raw.githubusercontent.com/PuNiSHeR374/Jeedom/master/v2/Patch/consistency.php -O /home/patch/consistency.php
