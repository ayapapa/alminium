#!/bin/sh

# java
yum install -y java-1.8.0-openjdk.x86_64

# jenkins
wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
yum install -y jenkins

rpm -vi --force inst-script/rhel6/mod_auth_mysql-3.0.0-11.el6.1.redmine.x86_64.rpm

#sed -i 's/JENKINS_JAVA_OPTIONS="-Djava.awt.headless/JENKINS_JAVA_OPTIONS="-Dhudson.diyChunking=false -Djava.awt.headless/' /etc/sysconfig/jenkins

sed -i 's/JENKINS_ARGS=""/JENKINS_ARGS="--prefix=\/jenkins"/' /etc/sysconfig/jenkins

service jenkins restart
