#!/bin/bash

# check user
if [ `whoami` != 'root' ]; then
    echo "ALMiniumのインストールはルートユーザで行う必要があります。"
    echo "rootユーザもしくはsudoで実行してください。"
    exit 1
fi

# build docker-alminium
git clone https://github.com/ayapapa/docker-alminium.git .test
pushd .test && rm -r .git
BRANCH_NAME="`git branch --contains=HEAD | awk '{print $2}'`"
sed -i.org \
    -e "s/ALM_VER=\"master\"/ALM_VER=\"$BRANCH_NAME\"/" \
    -e "s/wget/wget daemon net-tools default-jre-headless/" \
    Dockerfile
docker build -t ayapapa/docker-alminium .
popd
