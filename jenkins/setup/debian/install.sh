#!/bin/sh

wget -O cache/jenkins.deb http://pkg.jenkins-ci.org/debian-stable/binary/jenkins_1.651.3_all.deb
dpkg -i cache/jenkins.deb

sed -i 's/JAVA_ARGS="-Djava.awt.headless/JAVA_ARGS="-Dhudson.diyChunking=false -Djava.awt.headless/' /etc/default/jenkins
sed -i 's/JENKINS_ARGS="--webroot/JENKINS_ARGS="--prefix=\/jenkins --webroot/' /etc/default/jenkins

service jenkins restart
