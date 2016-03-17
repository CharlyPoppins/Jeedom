#!/bin/sh

# Mise à jour des Paquets
sudo apt-get update
sudo apt-get install git-core curl build-essential openssl libssl-dev

cd /tmp

# Récupèration NodeJs depuis Github
git clone https://github.com/joyent/node.git
cd node

# Récupération de la dernière version stable (actuellement 0.10.40)
git checkout v0.10.40

# Compilation et Installation
./configure
make
sudo make install

# Vérification de la Version NodeJs
node -v

# Installation NPM
curl -L https://www.npmjs.org/install.sh | sh

# Vérification de la Version NPM
npm -v
