#!/bin/bash

# Redmine Perlモジュール（リポジトリ認証連携）設定
mkdir -p /etc/httpd/Apache/Authn
rm -f /etc/httpd/Apache/Authn/Redmine.pm
ln -s ${ALM_INSTALL_DIR}/extra/svn/Redmine.pm /etc/httpd/Apache/Authn/Redmine.pm

#
# Apache configs
#
# passenger check
#passenger-config validate-install --auto --validate-apache2
# mod_passenger
#pushd ${ALM_INSTALL_DIR}
#bundle exec passenger-install-apache2-module --snippet > ${ALM_ETC_DIR}/passenger.conf
#bundle exec passenger-install-apache2-module --auto --apxs2-path='/usr/bin/apxs'
#ruby ${ALM_INSTALL_DIR}/vendor/bundle/ruby/2.5.0/gems/passenger-5.3.1/bin/passenger-install-apache2-module --apxs2-path='/usr/bin/apxs'
#popd
#ln -sf "${ALM_ETC_DIR}/passenger.conf" "${APACHE_CONF_DIR}/"

##set alminium config
#ln -sf "${ALM_ETC_DIR}/alminium.conf"  "${APACHE_CONF_DIR}/"

# セキュリティ無効化の設定
if [ ! "${USE_DISABLE_SECURITY}" = "n" ]; then
  echo "SELinuxを無効化します"
  setenforce 0
  CHK=`grep SELINUX=enforcing /etc/selinux/config`
  if [ ! "${CHK}" = '' ]; then
    sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config 
    echo "SELinuxが無効化されました"
  fi

  # ファイアウォールの設定で80番(http)および443番(https)を許可
  firewall-cmd --add-service=http --add-service=https --zone=public --permanent
  firewall-cmd --reload
  firewall-cmd --list-all
fi

# MariaDB設定
CHK=`grep "character-set-server=utf8" /etc/my.cnf`
if [ "${CHK}" = "" ]; then
  mv /etc/my.cnf /etc/my.cnf.org
  cat /etc/my.cnf.org | sed -e "s/\[mysqld_safe\]/character-set-server=utf8\n\n\[mysqld_safe\]/g" > /etc/my.cnf
  echo -e "\n[mysql]\ndefault-character-set=utf8\n" >> /etc/my.cnf
fi

#chkconfig --add httpd
chkconfig httpd on

