#!/bin/sh

wget -q -O - http://pkg.jenkins-ci.org/debian-stable/jenkins-ci.org.key | sudo apt-key add -
echo "deb http://pkg.jenkins-ci.org/debian-stable binary/" > /etc/apt/sources.list.d/jenkins.list
apt-get -q2 update
apt-get -y install jenkins
sed -i 's/JENKINS_ARGS="--webroot/JENKINS_ARGS="--prefix=\/jenkins -Dhudson.diyChunking=false --webroot/' /etc/default/jenkins

service jenkins restart
