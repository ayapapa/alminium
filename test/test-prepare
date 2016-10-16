#!/bin/bash

# check user
if [ `whoami` != 'root' ]; then
    echo "ALMiniumのインストールはルートユーザで行う必要があります。"
    echo "rootユーザもしくはsudoで実行してください。"
    exit 1
fi

# package update and minimum install
apt-get update -q
apt-get install -q git curl

# install doccker
curl -fsSL https://get.docker.com/ | sh
curl -L https://github.com/docker/compose/releases/download/1.8.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

