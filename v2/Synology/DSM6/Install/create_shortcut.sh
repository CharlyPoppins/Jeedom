#!/bin/sh

cd /tmp

wget https://github.com/PuNiSHeR374/Jeedom/raw/master/v2/Synology/DSM6/Install/SynoIconShortcut.zip

7z x SynoIconShortcut.zip -o/volume1/@appstore

ln -s /volume1/@appstore/jeedom/ui /usr/syno/synoman/webman/3rdparty/jeedom

rm SynoIconShortcut.zip