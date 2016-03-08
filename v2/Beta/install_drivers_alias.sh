#!/bin/sh
wget http://github.com/sarakha63/Jeedom_Syno/raw/master/Syno/cp210x.ko
wget http://github.com/sarakha63/Jeedom_Syno/raw/master/Syno/ftdi_sio.ko
wget http://github.com/sarakha63/Jeedom_Syno/raw/master/Syno/usbserial.ko
wget http://github.com/sarakha63/Jeedom_Syno/raw/master/Syno/S99Modules.sh
mv *.ko /lib/modules
mv S99Modules.sh /usr/syno/etc.defaults/rc.d/
chmod 777 /usr/syno/etc.defaults/rc.d/S99Modules.sh
cp /bin/ash /usr/local/debian-chroot/var/chroottarget/bin/
echo 'alias debian="chroot /usr/local/debian-chroot/var/chroottarget/ /bin/bash"' >> ~/.profile
rm /volume1/debian
ln -s /usr/local/debian-chroot/var/chroottarget/ /volume1/debian
wget http://github.com/sarakha63/Jeedom_Syno/raw/master/Syno/jeedom.zip
unzip jeedom.zip -d /volume1/@appstore
ln -s /volume1/@appstore/jeedom/ui /usr/syno/synoman/webman/3rdparty/jeedom
