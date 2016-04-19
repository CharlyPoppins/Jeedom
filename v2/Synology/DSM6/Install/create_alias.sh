#!/bin/sh

cp /bin/ash /usr/local/debian-chroot/var/chroottarget/bin/

echo 'alias debian="chroot /usr/local/debian-chroot/var/chroottarget/ /bin/bash"' >> ~/.profile

rm /volume1/debian

ln -s /usr/local/debian-chroot/var/chroottarget/ /volume1/debian

wget https://github.com/PuNiSHeR374/Jeedom/raw/master/v2/Synology/DSM6/Install/SynoIconShortcut.zip

7z x SynoIconShortcut.zip -o/volume1/@appstore

ln -s /volume1/@appstore/jeedom/ui /usr/syno/synoman/webman/3rdparty/jeedom

rm SynoIconShortcut.zip
