#!/bin/sh

# install depend packages
if [ "${JENKINS_SYS}" = "debian" -a "${OS}" = "debian" ]; then
# 7はサポートされなくなっていた（2018/6/3時点） 
#  apt-get install -y openjdk-7-jre-headless
  add-apt-repository ppa:webupd8team/java -y
  apt-get update
  apt-get install oracle-java8-installer -y
else # ubuntu1404より新しいDebian系OS
  apt-get install -y openjdk-9-jre-headless
fi

# download and install jenkins 
wget -q -O - http://pkg.jenkins-ci.org/debian-stable/jenkins-ci.org.key | sudo apt-key add -
echo "deb http://pkg.jenkins-ci.org/debian-stable binary/" > /etc/apt/sources.list.d/jenkins.list
apt-get -q2 update
apt-get -y install jenkins

sed -i 's/JENKINS_ARGS="--webroot/JENKINS_ARGS="--prefix=\/jenkins --webroot/' /etc/default/jenkins

# restart jenkins
service jenkins restart
