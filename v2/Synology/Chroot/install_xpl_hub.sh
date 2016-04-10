#!/bin/sh
#
# Commande pour vérifier l'écoute du Hub :
# netstat -anp|grep 3865

cd /tmp

mkdir Hub_xPL

wget http://www.xpl4java.org/xPL4Linux/downloads/xPLLib.tgz
tar xvzf xPLLib.tgz

cd xPLLib

make

sudo make install

cd examples/

make

sudo cp xPL_Hub xPL_Logger /usr/local/bin

update-rc.d /usr/local/bin/xPL_Hub defaults

/usr/local/bin/xPL_Hub
