#!/bin/bash

# gitのソースコードをダウンロードしインストールする
pushd ${ALM_SRC_DIR}/cache
wget https://www.kernel.org/pub/software/scm/git/git-${ALM_GIT_VERSION}.tar.gz
tar xzvf git-${ALM_GIT_VERSION}.tar.gz
cd git-${ALM_GIT_VERSION}
make prefix=/usr all
make prefix=/usr install
echo git has been updated to `git --version | cut -c 5-`
popd

