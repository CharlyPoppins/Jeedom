#!/bin/bash

apt-get update
apt-get install sudo locales curl build-essential

cd /tmp

echo "Début de l'installation"

actual=`nodejs -v`;

echo "Version actuelle : ${actual}"

if [[ $actual == *"4."* || $actual == *"5."* ]]
then
  echo "Ok, version suffisante";
else
  echo "KO, version obsolète à upgrader";
  echo "Suppression du Nodejs existant et installation du paquet recommandé"
  sudo apt-get -y --purge autoremove nodejs* npm*
  
  arch=`arch`;

  if [[ $arch == "armv6l" ]]
  then
    echo "Raspberry 1 détecté, utilisation du paquet pour armv6"
    sudo rm /etc/apt/sources.list.d/nodesource.list
    wget http://node-arm.herokuapp.com/node_latest_armhf.deb
    sudo dpkg -i node_latest_armhf.deb
    sudo ln -s /usr/local/bin/nodejs /usr/local/bin/node
    rm node_latest_armhf.deb
  elif [[ $arch == "x86_64" ]]
  then
    wget https://nodejs.org/dist/v5.9.0/node-v5.9.0.tar.gz
    tar -xvzf node-v5.9.0.tar.gz
    
    cd node-v5.9.0
    
    ./configure
    make
    sudo make install
  else
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
