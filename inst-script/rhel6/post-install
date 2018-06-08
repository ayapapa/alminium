#!/bin/bash

# set Redmine.pm
if [ ! -f /etc/httpd/Apache/Authn/Redmine.pm ]; then
  mkdir -p /etc/httpd/Apache/Authn
  rm /etc/httpd/Apache/Authn/Redmine.pm
  ln -s ${ALM_INSTALL_DIR}/extra/svn/Redmine.pm /etc/httpd/Apache/Authn/Redmine.pm
fi

#
# set Apache
#
## mod_passenger
#pushd ${ALM_INSTALL_DIR}
#bundle exec passenger-install-apache2-module --snippet > ${ALM_ETC_DIR}/passenger.conf
#bundle exec passenger-install-apache2-module --auto
#popd
#ln -sf "${ALM_ETC_DIR}/passenger.conf" "${APACHE_CONF_DIR}/"

#set alminium config
#ln -sf "${ALM_ETC_DIR}/alminium.conf"  "${APACHE_CONF_DIR}/"

# セキュリティ無効化の設定
if [ ! "${USE_DISABLE_SECURITY}" = "n" ]; then
  # SELinuxを無効化
  echo 0 > /selinux/enforce
  CHK=`grep SELINUX=enforcing /etc/selinux/config`
  if [ ! "${CHK}" = '' ]; then
    sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config 
    echo "SELinuxが無効化されました"
  fi

  # ファイアウォールの設定で80番(http)を許可
  CHK=`grep "dport 80" /etc/sysconfig/iptables`
  if [ "${CHK}" = '' ]; then
    RULENUM=`iptables-save |grep INPUT |grep -n "dport 22"|awk -F : '{print $1}'`
    iptables -I  INPUT ${RULENUM} -p tcp -m state --state NEW -m tcp --dport 80 -j ACCEPT
    iptables-save > /etc/sysconfig/iptables
    echo "tcp 80番ポートのアクセスを許可しました"
  fi
  CHK=`grep "dport 443" /etc/sysconfig/iptables`
  if [ "${CHK}" = '' ]; then
    RULENUM=`iptables-save |grep INPUT |grep -n "dport 22"|awk -F : '{print $1}'`
    iptables -I  INPUT ${RULENUM} -p tcp -m state --state NEW -m tcp --dport 443 -j ACCEPT
    iptables-save > /etc/sysconfig/iptables
    echo "tcp 443番ポートのアクセスを許可しました"
  fi
fi

chkconfig --add httpd
chkconfig httpd on

