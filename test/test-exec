#!/bin/bash

# check user
if [ `whoami` != 'root' ]; then
    echo "ALMiniumのインストールはルートユーザで行う必要があります。"
    echo "rootユーザもしくはsudoで実行してください。"
    exit 1
fi

# start services
docker-compose -f ./test-docker-compose.yml up -d

# test
sleep 90 && curl -k https://localhost:14443/alminium/

