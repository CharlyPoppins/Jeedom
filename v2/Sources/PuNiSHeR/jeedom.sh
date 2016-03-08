#!/bin/sh
case "$1" in
   "start")
   /etc/init.d/rsyslog start
   /etc/init.d/mtab.sh start
   /etc/init.d/cron start
   /etc/init.d/nginx start
   /etc/init.d/mysql start
   /etc/init.d/php5-fpm start
   chmod 777 /dev/tty*
   /etc/init.d/jeedom start
   ;;
   "stop")
   /etc/init.d/jeedom stop
   /etc/init.d/php5-fpm stop
   /etc/init.d/mysql stop
   /etc/init.d/nginx stop
   /etc/init.d/cron stop
   /etc/init.d/mtab.sh stop
   /etc/init.d/rsyslog stop
   ;;
esac
