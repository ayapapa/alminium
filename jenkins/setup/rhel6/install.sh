#!/bin/sh

wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
yum install -y jenkins
yum install -y java-1.7.0-openjdk-devel
rpm -vi --force inst-script/rhel6/mod_auth_mysql-3.0.0-11.el6.1.redmine.x86_64.rpm

#CHK=`grep "dport 8080" /etc/sysconfig/iptables`
#if [ "$CHK" = '' ]
#then
#  RULENUM=`iptables-save |grep INPUT |grep -n "dport 22"|awk -F : '{print $1}'`
#  iptables -I  INPUT ${RULENUM} -p tcp -m state --state NEW -m tcp --dport 8080 -j ACCEPT
#  iptables-save > /etc/sysconfig/iptables
#fi

sed -i 's/JENKINS_ARGS=""/JENKINS_ARGS="--prefix=\/jenkins"/' /etc/sysconfig/jenkins

service jenkins restart
