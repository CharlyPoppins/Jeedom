#!/bin/sh

cd /tmp

wget https://github.com/PuNiSHeR374/Jeedom/raw/master/v2/Synology/DSM5/Install/SynoIconShortcut.zip

unzip SynoIconShortcut.zip -d /volume1/@appstore

ln -s /volume1/@appstore/jeedom/ui /usr/syno/synoman/webman/3rdparty/jeedom

rm SynoIconShortcut.zip
