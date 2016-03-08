#!/bin/sh
chmod 777 /dev/tty*
   apt-get update
	apt-get -y upgrade
    apt-get -y install
    apt-get -y install build-essential
	apt-get -y install sudo
    apt-get -y install curl
    apt-get -y install libarchive-dev
    apt-get -y install libav-tools
    apt-get -y install libjsoncpp-dev
    apt-get -y install libpcre3-dev
    apt-get -y install libssh2-php
    apt-get -y install libtinyxml-dev
    apt-get -y install libxml2
    apt-get -y install make
    apt-get -y install miniupnpc
    apt-get -y install apache2
	apt-get -y install libarchive-dev
	apt-get -y install libav-tools
	apt-get -y install libjsoncpp-dev
	apt-get -y install libpcre3-dev
	apt-get -y install libssh2-php
	apt-get -y install libtinyxml-dev
	apt-get -y install libxml2
	#apt-get -y install mysql-client
    #apt-get -y install mysql-common
    #apt-get -y install mysql-server
    #apt-get -y install mysql-server-core-5.5
    apt-get -y install ntp
	apt-get -y install php5-common libapache2-mod-php5 php5-cli
    apt-get -y install php5-curl
    apt-get -y install php5-dev
    apt-get -y install php5-fpm
    apt-get -y install php5-json
    apt-get -y install php5-mysql
    apt-get -y install php5-ldap
    apt-get -y install php-pear
    apt-get -y install python-serial
    apt-get -y install systemd
    apt-get -y install unzip
    apt-get -y install usb-modeswitch
    apt-get -y install ffmpeg
    apt-get -y install avconv
    apt-get -y install libudev1
    apt-get -y install ca-certificates
    apt-get -y install htop
	apt-get -y install zip
	apt-get -y install locales
	
	dpkg-reconfigure tzdata
	dpkg-reconfigure locales
	
echo "export LANG=fr_FR.utf8" >> ~/.bashrc
echo "export LC_ALL=fr_FR.utf8" >> ~/.bashrc

echo "cd /home" >> ~/.bashrc

# Version 1.XXX
# wget --no-check-certificate http://github.com/jeedom/core/raw/master/install/install.sh
#chmod 777 install.sh
#./install.sh

cd /tmp

# Version 2.1.1
wget https://github.com/jeedom/core/archive/stable.zip
unzip -v /tmp/stable.zip -d /var/www/html/

mv /tmp/core-stable  /var/www/html