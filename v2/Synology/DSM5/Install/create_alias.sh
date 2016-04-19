#!/bin/sh
cp /bin/ash /usr/local/debian-chroot/var/chroottarget/bin/
echo 'alias debian="chroot /usr/local/debian-chroot/var/chroottarget/ /bin/bash"' >> ~/.profile
rm /volume1/debian
ln -s /usr/local/debian-chroot/var/chroottarget/ /volume1/debian
wget http://github.com/sarakha63/Jeedom_Syno/raw/master/Syno/jeedom.zip
unzip jeedom.zip -d /volume1/@appstore
ln -s /volume1/@appstore/jeedom/ui /usr/syno/synoman/webman/3rdparty/jeedom
rm jeedom.zip
