#!/bin/sh

cd /tmp

wget http://github.com/PuNiSHeR374/Jeedom/raw/master/v2/Synology/DSM6/Drivers/cp210x.ko
wget http://github.com/PuNiSHeR374/Jeedom/raw/master/v2/Synology/DSM6/Drivers/ftdi_sio.ko
wget http://github.com/PuNiSHeR374/Jeedom/raw/master/v2/Synology/DSM6/Drivers/usbserial.ko
wget http://github.com/PuNiSHeR374/Jeedom/raw/master/v2/Synology/DSM6/Drivers/S99Modules.sh

mv *.ko /lib/modules

mv S99Modules.sh /usr/local/etc/rc.d/

chmod +x /usr/local/etc/rc.d/S99Modules.sh
