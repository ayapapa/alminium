#!/bin/bash

if [ -f /usr/bin/yum ]; then
    yum -y remove jenkins
elif [ -f /usr/bin/apt-get ]; then
    apt-get -y remove jenkins
fi
rm -fr /var/lib/jenkins
