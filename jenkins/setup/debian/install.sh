#!/bin/sh

# install depend packages
if [ "${JENKINS_SYS}" = "ubuntu1604" ]; then
  apt-get install -y openjdk-9-jre-headless
else # ubuntu1404 case
  apt-get install -y openjdk-7-jre-headless
fi

# download and install jenkins 
wget -q -O - http://pkg.jenkins-ci.org/debian-stable/jenkins-ci.org.key | sudo apt-key add -
echo "deb http://pkg.jenkins-ci.org/debian-stable binary/" > /etc/apt/sources.list.d/jenkins.list
apt-get -q2 update
apt-get -y install jenkins

sed -i 's/JENKINS_ARGS="--webroot/JENKINS_ARGS="--prefix=\/jenkins --webroot/' /etc/default/jenkins

# restart jenkins
service jenkins restart
