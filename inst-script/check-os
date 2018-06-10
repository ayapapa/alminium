#!/bin/bash
# ネットワーク0のデバイス名

echo オペレーティングシステムをチェックします。

#IPアドレス確認用文字列
ETH0=${ETH0:-eth0}

# check OS
if [ "${OS}" = "" ]; then
  if [ -f /etc/redhat-release ]; then
    APACHE_USER=apache
    APACHE_CONF_DIR=/etc/httpd/conf.d
    APACHE_SITE_CONF_DIR=${APACHE_CONF_DIR}
    APACHE_LOG_DIR=httpd
    MYSQL_LOG_DIR=mysql
    MYSQLD='/etc/init.d/mysqld'
    CHK=`egrep "CentOS release 5|Red Hat Enterprise Linux .* 5" /etc/redhat-release`
    if [ "${CHK}" != '' ]; then
        OS='rhel5'
        echo "RHEL 5.x / CentOS 5.x / OEL 5.xが検出されました。"
        echo "RHEL 5.x / CentOS 5.x / OEL 5.xは、サポートされていません。"
        echo "インストールを中止します。"
        exit 1
    fi
    CHK=`egrep "CentOS Linux release 7" /etc/redhat-release`
    if [ "${CHK}" != '' ]; then
        OS='rhel7'
        echo "CentOS 7.x が検出されました。"
        MYSQL_LOG_DIR=mariadb
        MYSQLD='service mariadb'
        ETH0=enp0s3
    else
        OS='rhel6'
        echo "CentOS 6.xが検出されました。"
    fi
  elif [ -f /etc/debian_version -a "`grep 14.04 /etc/issue`" != "" ]; then
    APACHE_USER=www-data
    APACHE_CONF_DIR=/etc/apache2/mods-enabled
    APACHE_SITE_CONF_DIR=/etc/apache2/sites-available
    APACHE_LOG_DIR=apache2
    MYSQL_LOG_DIR=mysql
    MYSQLD='/etc/init.d/mysql'
    OS='debian'
    echo "Ubuntu 14.04 が検出されました。"
  elif [ -f /etc/lsb-release ]; then
    APACHE_USER=www-data
    APACHE_CONF_DIR=/etc/apache2/mods-enabled
    APACHE_SITE_CONF_DIR=/etc/apache2/sites-available
    APACHE_LOG_DIR=apache2
    MYSQL_LOG_DIR=mysql
    MYSQLD='/etc/init.d/mysql'
    ETH0=enp0s3
    if [ "`grep 16.04 /etc/lsb-release`" != "" ]; then
      OS='ubuntu1604'
      echo "Ubuntu 16.04 が検出されました。"
    elif [ "`grep 17.10 /etc/lsb-release`" != "" ]; then
      OS='ubuntu1710'
      echo "17.10 が検出されました。"
    elif [ "`grep 18.04 /etc/lsb-release`" != "" ]; then
      OS='ubuntu1804'
      echo "18.04 が検出されました。"
    fi
  fi
fi
if [ "${OS}" = "" ]; then
  echo "サポートされていないOSです。"
  echo "現在サポートされいているOSは、"
  echo "  * Ubuntu 14.04/16.04/17.10/18.04"
  echo "  * CentOS 6.0/7.0"
  echo "です。処理を中止します。"
  exit 1
fi

