#!/bin/sh

# install depend packages
if [ "${OS}" = "debian" ]; then
# 7はサポートされなくなっていた（2018/6/3時点） 
#  apt-get install -y openjdk-7-jre-headless
  if [ "`which java`" != "" ]; then
    apt-get remove -y openjdk-7-jre-headless
  fi
  apt-get install -y python-software-properties debconf-utils
  add-apt-repository -y ppa:webupd8team/java
  apt-get update
  echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
  apt-get install -y oracle-java8-installer
else # ubuntu1404より新しいUbuntu
  if [ "`which java`" = "" ]; then
    apt-get install -y openjdk-8-jre-headless
  fi
fi

# download and install jenkins 
wget -q -O - http://pkg.jenkins-ci.org/debian-stable/jenkins-ci.org.key | sudo apt-key add -
echo "deb http://pkg.jenkins-ci.org/debian-stable binary/" > /etc/apt/sources.list.d/jenkins.list
apt-get -q2 update
apt-get -y install jenkins

sed -i 's/JENKINS_ARGS="--webroot/JENKINS_ARGS="--prefix=\/jenkins --webroot/' /etc/default/jenkins

# restart jenkins
service jenkins restart
