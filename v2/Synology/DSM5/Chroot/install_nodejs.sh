#!/bin/bash

apt-get update
apt-get -y install sudo locales curl build-essential

cd /tmp

echo "Installation de Node JS"

actual=`nodejs -v`;

echo "Version actuelle : ${actual}"

if [[ $actual == *"4."* || $actual == *"5."* ]]
then
	echo "Ok, version suffisante";
else
	echo "KO, version obsolète à upgrader";
	echo "Suppression du Nodejs existant et installation du paquet recommandé"
	sudo apt-get -y --purge autoremove nodejs npm
	arch=`arch`;

	if [[ $arch == "armv6l" || $arch == "armv7l" ]]
	then
		sudo rm /etc/apt/sources.list.d/nodesource.list
		wget http://node-arm.herokuapp.com/node_latest_armhf.deb
		sudo dpkg -i node_latest_armhf.deb
		sudo ln -s /usr/local/bin/node /usr/local/bin/nodejs
		rm node_latest_armhf.deb
	fi

	if [[ $arch == "aarch64" ]]
	then
		wget http://dietpi.com/downloads/binaries/c2/nodejs_5-1_arm64.deb
		sudo dpkg -i nodejs_5-1_arm64.deb
		sudo ln -s /usr/local/bin/node /usr/local/bin/nodejs
		rm nodejs_5-1_arm64.deb
	fi

	if [[ $arch != "aarch64" && $arch != "armv6l" ]]
	then
		echo "Utilisation du dépot officiel"
		curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
		sudo apt-get install -y nodejs
	fi
	new=`nodejs -v`;
	echo "Version actuelle : ${new}"
fi

npm cache clean
sudo npm cache clean

echo "Fin de l'installation"
