#!/bin/sh

echo ""; echo "";
echo "**********************************************************"
echo "Patch Jeedom v2.4.6"
echo ""
echo "Démarrage du Correctif du Cache Jeedom."
echo "**********************************************************"
echo "";

classDir=$(find /var/www -iname class -type d | egrep -v "tests|plugins")
installDir=$(find /var/www -iname install -type d)

echo ""; echo "";
echo "**********************************************************"
echo "Lancement d'un Backup Jeedom."
echo "**********************************************************"
echo "";

sudo php ${installDir}/backup.php

echo ""; echo "";
echo "**********************************************************"
echo "Backup des fichiers à Patcher."
echo "**********************************************************"
echo "";

sudo chmod 777 -R /var/www

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

sudo wget --no-check-certificate https://raw.githubusercontent.com/PuNiSHeR374/Jeedom/master/v2/Patch/cache.class.php -O ${classDir}/cache.class.php
sudo wget --no-check-certificate https://raw.githubusercontent.com/PuNiSHeR374/Jeedom/master/v2/Patch/cmd.class.php -O ${classDir}/cmd.class.php
sudo wget --no-check-certificate https://raw.githubusercontent.com/PuNiSHeR374/Jeedom/master/v2/Patch/cron.class.php -O ${classDir}/cron.class.php
sudo wget --no-check-certificate https://raw.githubusercontent.com/PuNiSHeR374/Jeedom/master/v2/Patch/eqLogic.class.php -O ${classDir}/eqLogic.class.php
sudo wget --no-check-certificate https://raw.githubusercontent.com/PuNiSHeR374/Jeedom/master/v2/Patch/scenario.class.php -O ${classDir}/scenario.class.php
sudo wget --no-check-certificate https://raw.githubusercontent.com/PuNiSHeR374/Jeedom/master/v2/Patch/consistency.php -O ${installDir}/consistency.php

echo ""; echo "";
echo "**********************************************************"
echo "Nettoyage du dossier TMP."
echo "**********************************************************"
echo "";

echo "Veuillez patienter, cela peut durer +/- 2 minutes."

sudo php ${installDir}/consistency.php

echo ""; echo "";
echo "**********************************************************"
echo "Mise à plat des droits."
echo "**********************************************************"
echo "";

sudo chmod 775 -R /var/www
sudo chown -R www-data:www-data /var/www

echo ""; echo "";
echo "**********************************************************"
echo "Redémarrage de Jeedom."
echo "**********************************************************"
echo "";

sudo reboot
