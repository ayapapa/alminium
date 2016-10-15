#!/bin/sh

wget -O cache/jenkins.deb http://pkg.jenkins-ci.org/debian-stable/binary/jenkins_1.651.3_all.deb
dpkg -i cache/jenkins.deb
sed -i 's/JENKINS_ARGS="--webroot/JENKINS_ARGS="--prefix=\/jenkins --webroot/' /etc/default/jenkins

service jenkins restart
