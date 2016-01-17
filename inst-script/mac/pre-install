#!/bin/bash
echo "*******************************************************"
echo "  セキュリティの設定"
echo "*******************************************************"
echo "ファイアフォールの設定はシステム環境設定から行ってください。"
echo "共有で、インターネット共有がHTTPSとSSLに、リモートログインがSSHに対応しています。"
echo -n

port install `grep -v "^#" inst-script/mac/packages.lst`

if [ "$ALM_ENABLE_SSL" = "y" ]
then
   port install openssl
fi

port load mysql55-server
port select mysql mysql55
sudo -u mysql /opt/local/lib/mysql55/bin/mysql_install_db
cp /opt/local/share/mysql55/support-files/my-small.cnf /opt/local/etc/mysql55/my.cnf

