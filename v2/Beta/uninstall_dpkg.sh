#!/bin/sh

apt-get -y upgrade
apt-get -y autoremove --purge build-essential
apt-get -y autoremove --purge Dialog
apt-get -y autoremove --purge curl
apt-get -y autoremove --purge make
apt-get -y autoremove --purge mc
apt-get -y autoremove --purge vim
apt-get -y autoremove --purge unzip
apt-get -y autoremove --purge htop
apt-get -y autoremove --purge mysql-client
apt-get -y autoremove --purge nginx
apt-get -y autoremove --purge php5-fpm
apt-get -y autoremove --purge php5-curl
apt-get -y autoremove --purge php5-dev
apt-get -y autoremove --purge php5-json
apt-get -y autoremove --purge php5-mysql
apt-get -y autoremove --purge php5-ldap
apt-get -y autoremove --purge php5-gd
apt-get -y autoremove --purge php-pear
apt-get -y autoremove --purge ca-certificates
apt-get -y autoremove --purge apache2