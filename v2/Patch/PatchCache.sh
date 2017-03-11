#!/bin/sh

echo ""; echo "";
echo "**********************************************************"
echo "Patch Jeedom v2.4.6"
echo ""
echo "Démarrage du Correctif du Cache Jeedom."
echo "**********************************************************"
echo "";


echo ""; echo "";
echo "**********************************************************"
echo "Lancement d'un Backup Jeedom."
echo "**********************************************************"
echo "";

sudo php $(find /var/www -iname backup.php -type f)

echo ""; echo "";
echo "**********************************************************"
echo "Backup des fichiers à Patcher."
echo "**********************************************************"
echo "";

sudo chmod 0777 -R /var/www

classDir=$(find /var/www -iname class -type d | egrep -v "tests|plugins")
installDir=$(find /var/www -iname install -type d)

sudo cp -v -p ${classDir}/cache.class.php ${classDir}/cache.class.php.bck
sudo cp -v -p ${classDir}/cmd.class.php ${classDir}/cmd.class.php.bck
sudo cp -v -p ${classDir}/cron.class.php ${classDir}/cron.class.php.bck
sudo cp -v -p ${classDir}/eqLogic.class.php ${classDir}/eqLogic.class.php.bck
sudo cp -v -p ${classDir}/scenario.class.php ${classDir}/scenario.class.php.bck
sudo cp -v -p ${installDir}/consistency.php ${installDir}/consistency.php.bck

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
