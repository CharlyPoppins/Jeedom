#!/bin/sh
wget http://github.com/sarakha63/Jeedom_Syno/raw/master/Syno/cp210x.ko
wget http://github.com/sarakha63/Jeedom_Syno/raw/master/Syno/ftdi_sio.ko
wget http://github.com/sarakha63/Jeedom_Syno/raw/master/Syno/usbserial.ko
wget http://github.com/sarakha63/Jeedom_Syno/raw/master/Syno/S99Modules.sh
mv *.ko /lib/modules
mv S99Modules.sh /usr/syno/etc.defaults/rc.d/
chmod 777 /usr/syno/etc.defaults/rc.d/S99Modules.sh
