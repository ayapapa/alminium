#!/bin/sh

# install depend packages
if [ "$OS" = "ubuntu1604" ]; then
  apt-get install -y openjdk-9-jre-headless
else # ubuntu1404 case
  apt-get install -y openjdk-7-jre-headless
fi
apt-get install -y daemon

# download and install jenkins 
wget -O cache/jenkins.deb http://pkg.jenkins-ci.org/debian-stable/binary/jenkins_1.651.3_all.deb
dpkg -i cache/jenkins.deb

# avoid issue https://issues.jenkins-ci.org/browse/JENKINS-23232
# and   issue https://issues.jenkins-ci.org/browse/JENKINS-35197
sed -i 's/JAVA_ARGS="-Djava.awt.headless/JAVA_ARGS="-Dhudson.diyChunking=false -Djava.awt.headless/' /etc/default/jenkins
sed -i 's/JENKINS_ARGS="--webroot/JENKINS_ARGS="--prefix=\/jenkins --webroot/' /etc/default/jenkins

# restart jenkins
service jenkins restart
