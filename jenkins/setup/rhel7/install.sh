#!/bin/sh

wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
yum install -y jenkins

sed -i 's/JENKINS_ARGS=""/JENKINS_ARGS="--prefix=\/jenkins"/' /etc/sysconfig/jenkins

service jenkins restart
