#!/bin/sh
# Jeedom  chroot V2.1.1
#stef74
case "$1" in
   "start")
   /etc/init.d/rsyslog start
   #/etc/init.d/mtab.sh start
   /etc/init.d/cron start
   /etc/init.d/apache2 start
   /etc/init.d/php5-fpm start
   chmod 777 /dev/tty*
   ;;
   "stop")
   /etc/init.d/php5-fpm stop
   /etc/init.d/apache2 stop
   /etc/init.d/cron stop
   #/etc/init.d/mtab.sh stop
   /etc/init.d/rsyslog stop
   ;;
esac
