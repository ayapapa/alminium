#!/bin/sh

wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
rpm --import http://pkg.jenkins-ci.org/redhat-stable/jenkins-ci.org.key
yum clean all
yum install -y jenkins
yum install -y java-1.7.0-openjdk-devel
rpm -vi --force inst-script/rhel6/mod_auth_mysql-3.0.0-11.el6.1.redmine.x86_64.rpm

sed -i 's/JENKINS_ARGS=""/JENKINS_ARGS="--prefix=\/jenkins -Dhudson.diyChunking=false"/' /etc/sysconfig/jenkins

service jenkins restart
