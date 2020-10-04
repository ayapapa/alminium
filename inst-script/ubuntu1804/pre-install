#!/bin/bash

# non-interactive mode
export DEBIAN_FRONTEND=noninteractive

# package list update
apt-get -qq update && apt-get install -y --no-install-recommends apt-utils

# add passenger to APT repository
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
apt-get install -y --no-install-recommends ca-certificates
apt-get install -y --allow-change-held-packages --no-install-recommends apt-transport-https
#echo deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main > /etc/apt/sources.list.d/passenger.list
#chown root: /etc/apt/sources.list.d/passenger.list
## remove old passenger's info 
#if [ "`ls /etc/apache2/mods-available/passenger.load 2>/dev/null`" != "" \
#     -a ! -f /etc/apache2/mods-available/passenger.load ]; then
#  rm -f /etc/apache2/mods*/passenger.*
#fi
#  set passenger-package available
#ALM_PASSSENGER_PACKAGE_AVAILABLE=1

# ubuntu1804 use apparmor
APPARMOR_ENABLED=1

# for Jenkins installation
JENKINS_SYS=debian

# install APT packages
if [ "${GIT_UPDATE}" = "y" ]; then
  add-apt-repository -y ppa:git-core/ppa
fi
apt-get -qq update
apt-get install -y --no-install-recommends `grep -v "^#" inst-script/${OS}/packages.lst`

REALLY_GEM_UPDATE_SYSTEM=1 gem update --system 2.7.10

# SSL
if [ "${ALM_ENABLE_SSL}" = "y" ]; then
    apt-get -y --no-install-recommends install ssl-cert
    a2enmod ssl rewrite
else
    a2dismod ssl
fi

# DB
if [ "${ALM_DB_SETUP}" = "y" -a "${ALM_USE_EXISTING_DB}" != "y" ]; then
  apt-get install -y --no-install-recommends mysql-server
  service mysql start
fi

