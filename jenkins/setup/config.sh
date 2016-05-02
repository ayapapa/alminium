#!/bin/bash

if [ ! -f /var/lib/jenkins/plugins ]; then
  mkdir /var/lib/jenkins/plugins
  chown jenkins:jenkins /var/lib/jenkins/plugins
fi

# download jenkins-cli.jar
sleep 10
RET=-1
until  [ "$RET" -eq "0" ]
do
  sleep 3
  wget --no-proxy -O $ALM_INSTALL_DIR/bin/jenkins-cli.jar http://localhost:8080/jenkins/jnlpJars/jenkins-cli.jar
  RET=$?
done

wget -O /tmp/default.js http://updates.jenkins-ci.org/update-center.json

# remove first and last line javascript wrapper
sed '1d;$d' /tmp/default.js > /tmp/default.json

# Now push it to the update URL
#curl --noproxy localhost -X POST -H "Accept: application/json" -d @/tmp/default.json http://localhost:8080/jenkins/updateCenter/byId/default/postBack --verbose
if [ ! -e /var/lib/jenkins/updates ]; then
  mkdir /var/lib/jenkins/updates
fi
cp -f /tmp/default.json /var/lib/jenkins/updates/

# Jenkinsのプロキシ設定
if [ x"$http_proxy" != x"" ]; then
  # set proxy. sorry IPv4 only and user:pass not supported...
  proxyuser=`echo $http_proxy | sed -n 's/.*:\/\/\([a-zA-Z0-9]*\):.*/\1/p'`
  proxypass=`echo $http_proxy | sed -n 's/.*:\/\/[a-zA-Z0-9]*:\([a-zA-Z0-9:]*\)\@.*/\1/p'`
  echo
  echo proxyuser=$proxyuser
  echo proxypass=$proxypass

  if [ x"$proxyuser" != x"" ]; then
    http_proxy=`echo $http_proxy | sed "s/$proxyuser:$proxypass\@//"`
  fi

  proxyserver=`echo $http_proxy | cut -d':' -f2 | sed 's/\/\///g'`
  proxyport=`echo $http_proxy | cut -d':' -f3 | sed 's/\///g'`
  echo proxyserver=$proxyserver
  echo proxyport=$proxyport

  curl --noproxy localhost -X POST --data "json={\"name\": \"$proxyserver\", \"port\": \"$proxyport\", \"userName\": \"$proxyuser\", \"password\": \"$proxypass\", \"noProxyHost\": \"\"}" http://localhost:8080/jenkins/pluginManager/proxyConfigure --verbose
  RET=$?
  if [ "$RET" -ne "0" ]; then
    echo "proxy setting for jenkins fail"
    exit 1
  fi
  #service jenkins restart
fi

# プラグインインストール
sleep 10
mkdir tmp
pushd tmp
RET=-1
until  [ "$RET" -eq "0" ]
do
  sleep 3
  java -jar $ALM_INSTALL_DIR/bin/jenkins-cli.jar -s http://localhost:8080/jenkins/ install-plugin reverse-proxy-auth-plugin
  RET=$?
done

java -jar $ALM_INSTALL_DIR/bin/jenkins-cli.jar -s http://localhost:8080/jenkins/ install-plugin persona
java -jar $ALM_INSTALL_DIR/bin/jenkins-cli.jar -s http://localhost:8080/jenkins/ install-plugin git
java -jar $ALM_INSTALL_DIR/bin/jenkins-cli.jar -s http://localhost:8080/jenkins/ install-plugin redmine
java -jar $ALM_INSTALL_DIR/bin/jenkins-cli.jar -s http://localhost:8080/jenkins/ install-plugin dashboard-view
popd
rm -rf tmp

# persona-hudmi取得
if [ ! -d /var/lib/jenkins/persona ]; then
  git clone https://github.com/okamototk/jenkins-persona-hudmi /var/lib/jenkins/persona
fi

if [ ! -f /var/lib/jenkins/config.xml ]; then
  cp jenkins/config.xml /var/lib/jenkins/config.xml
fi

chown -R jenkins:jenkins /var/lib/jenkins/
service jenkins restart
