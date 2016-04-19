#!/bin/sh

cd /tmp

wget http://github.com/PuNiSHeR374/Jeedom/raw/master/v2/Synology/DSM5/Drivers/cp210x.ko
wget http://github.com/PuNiSHeR374/Jeedom/raw/master/v2/Synology/DSM5/Drivers/ftdi_sio.ko
wget http://github.com/PuNiSHeR374/Jeedom/raw/master/v2/Synology/DSM5/Drivers/usbserial.ko
wget http://github.com/PuNiSHeR374/Jeedom/raw/master/v2/Synology/DSM5/Drivers/S99Modules.sh

mv *.ko /lib/modules

mv S99Modules.sh /usr/syno/etc.defaults/rc.d/

chmod +x /usr/syno/etc.defaults/rc.d/S99Modules.sh
