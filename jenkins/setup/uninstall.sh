#!/bin/bash

if [ -f /usr/bin/yum ]; then
    yum -y remove jenkins
elif [ -f /usr/bin/apt-get ]; then
    apt-get -y purge jenkins
fi
rm -fr /var/lib/jenkins
