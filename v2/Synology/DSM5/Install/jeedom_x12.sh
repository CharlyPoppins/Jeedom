#!/bin/sh
# Jeedom chroot V2.x.x Syno x12
#stef74

case "$1" in
   "start")
   /etc/init.d/rsyslog start
   /etc/init.d/cron start
   /etc/init.d/nginx start
   /etc/init.d/php5-fpm start
   chmod 777 /dev/tty*
   ;;
   "stop")
   /etc/init.d/php5-fpm stop
   /etc/init.d/nginx stop
   /etc/init.d/cron stop
   /etc/init.d/rsyslog stop
   ;;
esac
